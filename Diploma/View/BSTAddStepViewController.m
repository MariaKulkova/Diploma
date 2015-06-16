//
//  BSTAddStepViewController.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAddStepViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTAddStepViewController ()
@property (weak, nonatomic) IBOutlet UITextField *stepTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel *deadlineLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation BSTAddStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self addKeyboardHidingGesture];
	[super addAppTitle];
	[self.datePicker addTarget:self action:@selector(updateTextFieldDate:) forControlEvents:UIControlEventValueChanged];
}

- (void) updateTextFieldDate:(UIDatePicker *)picker{
	self.deadlineLabel.text = [NSString stringWithFormat:@"%@", picker.date];
}

@end
