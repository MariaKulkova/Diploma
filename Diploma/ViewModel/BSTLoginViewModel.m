//
//  BSTLoginViewModel.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTLoginViewModel.h"
#import "BSTParseClient.h"

@interface BSTLoginViewModel ()

@property (nonatomic, strong) RACSubject *webServiceSignal;

@end

@implementation BSTLoginViewModel

- (void)initialize {
	[super initialize];
	self.executionStatus = NO;
	[self bindValidation];
	
	@weakify(self);
	RACCommand *command;
	
	self.executeLogin =
	command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self login];
	}];

	[[command.executionSignals
	  switchToLatest]
		subscribeNext:^(NSDictionary *authInfo) {
			@strongify(self);
			NSLog(@"%@", authInfo);
			self.executionStatus = YES;
		}];

	[command.errors subscribeNext:^(NSError *error) {
		@strongify(self);
		NSLog(@"login: %@", error);
		self.executionStatus = NO;
	}];
}

- (void)bindValidation {
	
}

- (RACSignal *)login {
	return [BSTParseClient logInUser:self.username password:self.password];
}


@end
