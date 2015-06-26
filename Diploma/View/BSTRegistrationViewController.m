//
//  BSTRegistrationViewController.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTRegistrationViewController.h"
#import "BSTRegistrationViewModel.h"
#import <Parse/Parse.h>

@interface BSTRegistrationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (strong, nonatomic) BSTRegistrationViewModel *viewModel;

@end

@implementation BSTRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self bindModel];
}

- (void)bindModel {
	self.viewModel = [BSTRegistrationViewModel new];
	
	// Bind textfields to model
	RAC(self.viewModel, username) = self.loginTextField.rac_textSignal;
	RAC(self.viewModel, email)    = self.emailTextField.rac_textSignal;
	RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
	
	// Bind Create Account button to model
	self.signUpButton.rac_command = self.viewModel.executeRegistration;
	
	@weakify(self);
	
	// Observe viewmodel status
	[[RACObserve(self.viewModel, completionState) deliverOnMainThread] subscribeNext:^(NSNumber *status) {
		@strongify(self);
		
		if ([status boolValue]) {
			[self performSegueWithIdentifier:@"RootTabSegue" sender:self];
		}
	}];
}

- (IBAction)backTouch:(id)sender {
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signupButtonTouch:(id)sender {
}

@end
