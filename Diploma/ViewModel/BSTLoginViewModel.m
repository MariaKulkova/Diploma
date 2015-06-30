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
	
	// Bind user input validation to signal
	RACSignal *userInputSignal = [self bindValidation];
	
	// Bind web services to signal
	RACSubject *webServiceSignal =
	self.webServiceSignal        = [self bindWebServices];
	
	// Now combine two signals and bind them to viewModel execution status
	RAC(self, executionStatus) = [RACSignal
								  combineLatest:@[userInputSignal, webServiceSignal]
								  reduce:^id(BSTExecutionStatus *inputStatus, BSTExecutionStatus *webStatus) {
									  // Web status has greater priority, than input
									  return [webStatus isError] ? webStatus :
									  		 [inputStatus isCompleted] || [inputStatus isNormal] ? webStatus : inputStatus;
								  }];
	
	[self dropNetworkError];
}

- (RACSubject *)bindWebServices {
	RACSubject *webServiceSignal = [RACSubject subject];
	
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
			BSTExecutionStatus *status = [[BSTExecutionStatus completed] withSender:self.executeLogin];
			[webServiceSignal sendNext:status];
		}];
	
	[command.errors subscribeNext:^(NSError *error) {
		@strongify(self);
		NSLog(@"login: %@", error);
		NSString *description = error.localizedDescription;
		BSTExecutionStatus *status = [[BSTExecutionStatus error:description] withSender:self.executeLogin];
		[webServiceSignal sendNext:status];
	}];
	
	return webServiceSignal;
}

- (RACSignal *)bindValidation {
	RACSignal *validUsernameSignal = [RACObserve(self, username) map:^id(NSString *username) {
		BSTExecutionStatus *status = [BSTExecutionStatus normal];
		
		if (username.length == 0) {
			status = [BSTExecutionStatus hint:@"Enter username"];
		}
		
		return status;
	}];
	
	RACSignal *validPasswordSignal = [RACObserve(self, password) map:^id(NSString *password) {
		BSTExecutionStatus *status = [BSTExecutionStatus normal];
		
		if (password.length == 0) {
			status = [BSTExecutionStatus hint:@"Enter password"];
		}
		
		return status;
	}];
	
	// Combine two signals to one
	return [RACSignal
			combineLatest:@[validUsernameSignal, validPasswordSignal]
			reduce:^id(BSTExecutionStatus *usernameStatus, BSTExecutionStatus *passwordStatus) {
				return ![usernameStatus isNormal] ? usernameStatus :
				       ![passwordStatus isNormal] ? passwordStatus : [BSTExecutionStatus new];
			}];
}

- (void)dropNetworkError {
	[self.webServiceSignal sendNext:[BSTExecutionStatus normal]];
}

- (RACSignal *)login {
	return [BSTParseClient logInUser:self.username password:self.password];
}


@end
