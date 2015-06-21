//
//  BSTAddStepViewController.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAddStepViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BSTChangeStepViewModel.h"


@interface BSTAddStepViewController ()

@property (weak, nonatomic) IBOutlet UITextField  *stepTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel      *deadlineLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) BSTChangeStepViewModel *viewModel;

@end

@implementation BSTAddStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self addKeyboardHidingGesture];
	[super addAppTitle];
	[self.datePicker addTarget:self action:@selector(updateTextFieldDate:) forControlEvents:UIControlEventValueChanged];
	
	[self bindViewModel];
}

- (void) updateTextFieldDate:(UIDatePicker *)picker{
	self.deadlineLabel.text = [NSString stringWithFormat:@"%@", picker.date];
}

- (void)bindViewModel {
	self.viewModel = [BSTChangeStepViewModel new];
	
	if (self.selectedStep) {
		self.viewModel.objectId = self.selectedStep.id;
		self.stepTitleTextField.text = self.selectedStep.title;
	}
	else {
		self.viewModel.objectId = nil;
	}
	self.viewModel.selectedAim = self.selectedAim;
	RAC(self.viewModel, stepTitle) = self.stepTitleTextField.rac_textSignal;
}

- (IBAction)saveButtonTouch:(id)sender {
	[UIView performWithoutAnimation:^{
		[self.stepTitleTextField endEditing:YES];
	}];
	[[self.viewModel.executeStepChanging execute:nil] subscribeCompleted:^{
		[self.viewModel saveChanges];
		[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	}];
}

- (IBAction)cancelButtonTouch:(id)sender {
	[self.viewModel rollbackChanges];
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
