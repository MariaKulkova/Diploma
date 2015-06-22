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
#import "BSTNotificationViewController.h"


@interface BSTAddStepViewController ()

@property (weak, nonatomic) IBOutlet UITextField  *stepTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel      *deadlineLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *notificationView;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImage;
@property (weak, nonatomic) IBOutlet UILabel *dateNotificationLabel;

@property (strong, nonatomic) BSTChangeStepViewModel *viewModel;

@end

@implementation BSTAddStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self addKeyboardHidingGesture];
	[super addAppTitle];
	
	[self bindViewModel];
	[self.datePicker addTarget:self action:@selector(updateTextFieldDate:) forControlEvents:UIControlEventValueChanged];
	[self updateTextFieldDate:self.datePicker];
	
	if (self.selectedStep == nil) {
		self.notificationView.hidden = YES;
	}

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self updateReminderView];
}

- (void)updateReminderView {
	if (self.selectedStep.reminder != nil) {
		if (self.selectedStep.reminder.activated) {
			self.notificationImage.image = [UIImage imageNamed:@"NotificationActive"];
			NSDateFormatter *format = [[NSDateFormatter alloc] init];
			[format setDateFormat:@"dd MMM yyyy, HH:mm"];
			self.dateNotificationLabel.text = [format stringFromDate:self.selectedStep.reminder.date];
		}
		else {
			self.notificationImage.image = [UIImage imageNamed:@"NotificationInactive"];
			self.dateNotificationLabel.text = @"No reminder";
		}
	}
}

- (void) updateTextFieldDate:(UIDatePicker *)picker{
	self.viewModel.date = picker.date;
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"dd MMM yyyy, HH:mm"];
	NSString *dateString = [format stringFromDate:picker.date];
	self.deadlineLabel.text = [NSString stringWithFormat:@"%@", dateString];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"AddNotificationSegue"]) {
		BSTNotificationViewController *viewController = (BSTNotificationViewController *)[segue destinationViewController];
		viewController.selectedStep = self.selectedStep;
	}
}

- (void)bindViewModel {
	self.viewModel = [BSTChangeStepViewModel new];
	
	if (self.selectedStep) {
		self.viewModel.objectId = self.selectedStep.id;
		self.stepTitleTextField.text = self.selectedStep.title;
		[self.datePicker setDate:self.selectedStep.deadline];
	}
	else {
		self.viewModel.objectId = nil;
	}
	self.viewModel.selectedAim = self.selectedAim;
	
	RAC(self.viewModel, stepTitle) = self.stepTitleTextField.rac_textSignal;
	RAC(self.viewModel, date) = RACObserve(self.datePicker, date);
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
