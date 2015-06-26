//
//  BSTRegistrationViewModel.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTRegistrationViewModel.h"
#import "BSTParseClient.h"
#import <Parse/Parse.h>

@implementation BSTRegistrationViewModel

- (void)initialize {
	[super initialize];
	self.completionState = NO;
	
	[self bindValidation];
	
	@weakify(self);
	
	RACCommand *command;
//	RACSignal *enabled;
	
	// SignUp User
	
	self.executeRegistration =
	command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self createAccount];
	}];
	
	[[command.executionSignals
	  switchToLatest]
		subscribeNext:^(id x) {
			@strongify(self);
			self.completionState = YES;
		}];
	
	[command.errors subscribeNext:^(NSError *error) {
		@strongify(self);
		NSLog(@"createAccount: %@", error);
		self.completionState = NO;
	}];
}

- (void)bindValidation {
	
}

- (RACSignal *)createAccount {
	return [BSTParseClient signUpUser:self.username email:self.email password:self.password];
}

@end
