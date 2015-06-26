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
}

- (void)bindModel {
	self.viewModel = [BSTLoginViewModel new];
	
	RAC(self.viewModel, username) = self.loginTextField.rac_textSignal;
	RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
	
	self.loginButton.rac_command = self.viewModel.executeLogin;
	
	@weakify(self);
	
	// Observe viewmodel status
	[[RACObserve(self.viewModel, executionStatus) deliverOnMainThread] subscribeNext:^(NSNumber *status) {
		@strongify(self);
		
		if ([status boolValue]) {
			[self performSegueWithIdentifier:@"RootTabSegue" sender:self];
		}
	}];
}

@end
