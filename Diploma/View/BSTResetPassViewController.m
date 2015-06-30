//
//  BSTResetPassViewController.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTResetPassViewController.h"
#import "BSTResetPassViewModel.h"

@interface BSTResetPassViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (strong, nonatomic) BSTResetPassViewModel *viewModel;

@end

@implementation BSTResetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self bindModel];
}

- (void)bindModel {
	self.viewModel = [BSTResetPassViewModel new];
	
	RAC(self.viewModel, email) = self.emailTextField.rac_textSignal;
	self.resetButton.rac_command = self.viewModel.executePassReset;
	
	@weakify(self);
	
	// Observe viewmodel status
	[[RACObserve(self.viewModel, executionStatus) deliverOnMainThread] subscribeNext:^(BSTExecutionStatus *status) {
		@strongify(self);
		
		if ([status isCompleted] && status.sender == self.viewModel.executePassReset) {
			[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
		}
	}];
}

- (IBAction)backTouch:(id)sender {
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
