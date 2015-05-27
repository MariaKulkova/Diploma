//
//  BSTBaseViewController.m
//  Diploma
//
//  Created by Maria on 25.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTBaseViewController.h"

@interface BSTBaseViewController ()

@end

@implementation BSTBaseViewController

#pragma mark - Init

- (id)init {
	if (self = [super init]) {
		[self customInit];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self customInit];
	}
	return self;
}

- (void)customInit {
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self registerKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self removeKeyboardObservation];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

- (void)registerKeyboardNotifications {
	// register for keyboard notifications
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow)
												 name:UIKeyboardWillShowNotification
											   object:self.view.window];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide)
												 name:UIKeyboardWillHideNotification
											   object:self.view.window];
}

- (void)removeKeyboardObservation {
	// unregister from keyboard notifications
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillHideNotification
												  object:nil];
}

#pragma mark - Custom

- (void)addKeyboardHidingGesture {
	// Add hiding keyboard by tap on view
	UITapGestureRecognizer *endEditingTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	[self.view addGestureRecognizer:endEditingTapRecognizer];
}

- (void)hideKeyboard {
	[self.view endEditing:YES];
}

- (void)keyboardWillShow {
}

- (void)keyboardWillHide {
}

@end
