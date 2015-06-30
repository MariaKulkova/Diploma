//
//  BSTResetPassViewModel.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTResetPassViewModel.h"
#import "BSTParseClient.h"

@interface BSTResetPassViewModel ()

@property (nonatomic, strong) RACSubject *webServiceSignal;

@end

@implementation BSTResetPassViewModel

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
	
	self.executePassReset =
	command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self resetPass];
	}];
	
	[[command.executionSignals
	  switchToLatest]
		subscribeNext:^(NSDictionary *authInfo) {
			@strongify(self);
			NSLog(@"%@", authInfo);
			BSTExecutionStatus *status = [[BSTExecutionStatus completed] withSender:self.executePassReset];
			[webServiceSignal sendNext:status];
		}];
	
	[command.errors subscribeNext:^(NSError *error) {
		@strongify(self);
		NSLog(@"login: %@", error);
		NSString *description = error.localizedDescription;
		BSTExecutionStatus *status = [[BSTExecutionStatus error:description] withSender:self.executePassReset];
		[webServiceSignal sendNext:status];
	}];
	
	return webServiceSignal;
}

- (RACSignal *)bindValidation {
	RACSignal *validEmailSignal = [RACObserve(self, email) map:^id(NSString *email) {
		BSTExecutionStatus *status = [BSTExecutionStatus normal];
		
		if (email.length == 0) {
			status = [BSTExecutionStatus hint:@"Enter email"];
		}
		
		return status;
	}];
	
	return validEmailSignal;
}

- (void)dropNetworkError {
	[self.webServiceSignal sendNext:[BSTExecutionStatus normal]];
}

- (RACSignal *)resetPass {
	return [BSTParseClient resetPassword:self.email];
}

@end
