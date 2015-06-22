//
//  BSTLoginViewController.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTLoginViewController.h"
#import "BSTLoginViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BSTWebCore.h"

@interface BSTLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (strong, nonatomic) BSTLoginViewModel *viewModel;

@end

@implementation BSTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self bindModel];
	NSURLSession *session = BSTWebCore.parseSession;
//	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.parse.com/1/login?username=test&password=qwerty"]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.parse.com/1/users"]];
	request.allHTTPHeaderFields = session.configuration.HTTPAdditionalHeaders;
	request.HTTPMethod = @"POST";
	NSDictionary *info = @{@"username":@"maru", @"password":@"123456", @"email":@"maria35794@gmail.com"};
	NSData *rawData = [NSJSONSerialization dataWithJSONObject:info options:kNilOptions error:nil];
	request.HTTPBody = rawData;
	NSURLSessionDataTask *dataTask = [BSTWebCore.parseSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		NSLog(@"%@", json);
	}];
	
	[dataTask resume];
}

- (void)bindModel {
	self.viewModel = [BSTLoginViewModel new];
	
	RAC(self.viewModel, username) = self.loginTextField.rac_textSignal;
	RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
	
	self.loginButton.rac_command = self.viewModel.executeLogin;
}

@end
