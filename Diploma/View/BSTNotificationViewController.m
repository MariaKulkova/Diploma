//
//  BSTNotificationViewController.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTNotificationViewController.h"
#import "BSTNotificationViewModel.h"

@interface BSTNotificationViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *activationSwitch;
@property (weak, nonatomic) IBOutlet UITextField *periodTextField;

@property (strong, nonatomic) BSTNotificationViewModel *viewModel;

@property (assign, nonatomic) BOOL activated;

@end

@implementation BSTNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.datePicker addTarget:self action:@selector(updateTextFieldDate:) forControlEvents:UIControlEventValueChanged];
	
	[super addAppTitle];
	
	[self bindModel];
	[self updateTextFieldDate:self.datePicker];
}

- (void)bindModel {
	self.viewModel = [BSTNotificationViewModel new];
	
	RAC(self.viewModel, activated) = RACObserve(self.activationSwitch, on);
	RAC(self.viewModel, period) = [self.periodTextField.rac_textSignal map:^id(NSString *value) {
		return [NSNumber numberWithInt:[value intValue]];
	}];
//	RAC(self.viewModel, date) = RACObserve(self.datePicker, date);
	
	if (self.selectedStep.reminder != nil) {
		self.activationSwitch.on = self.selectedStep.reminder.activated;
		self.periodTextField.text = [NSString stringWithFormat:@"%lld", self.selectedStep.reminder.period];
		[self.datePicker setDate:self.selectedStep.reminder.date animated:NO];
		self.viewModel.objectId = self.selectedStep.reminder.id;
		self.viewModel.date = self.selectedStep.reminder.date;
		self.viewModel.activated = self.selectedStep.reminder.activated;
		self.viewModel.period = (int)self.selectedStep.reminder.period;
	}
	else {
		self.viewModel.objectId = nil;
	}
	
	self.viewModel.selectedStep = self.selectedStep;
}

- (void) updateTextFieldDate:(UIDatePicker *)picker{
	self.viewModel.date = picker.date;
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"dd MMM yyyy, HH:mm"];
	NSString *dateString = [format stringFromDate:picker.date];
	self.label.text = dateString;
}

- (IBAction)activationChanged:(id)sender {
	self.viewModel.activated = self.activationSwitch.on;
}

- (IBAction)saveAction:(id)sender {
	[[self.viewModel.executeNotificationChanging execute:nil] subscribeCompleted:^{
		[self.viewModel saveChanges];
		[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	}];
}

- (IBAction)backTouch:(id)sender {
	[self.viewModel rollbackChanges];
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
