//
//  BSTLoginViewModel.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTLoginViewModel.h"
#import "BSTParseAPIClient.h"

@interface BSTLoginViewModel ()

@property (nonatomic, strong) RACSubject *webServiceSignal;

@end

@implementation BSTLoginViewModel

- (void)initialize {
	[super initialize];
	
	// Bind user input validation to signal
//	RACSignal *userInputSignal = [self bindValidation];
	
	// Bind web services to signal
	RACSubject *webServiceSignal =
	self.webServiceSignal        = [self bindWebServices];
	
//	RAC(self, executionStatus) = [RACSignal
//								  combineLatest:@[userInputSignal, webServiceSignal]
//								  reduce:^id(FWStatusTuple *inputStatus, FWStatusTuple *webStatus) {
//									  return [webStatus isError]   ? webStatus :
//									  [inputStatus isValid] ? webStatus : inputStatus;
//								  }];
//	
//	[self dropNetworkError];
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
		}];
	
	[command.errors subscribeNext:^(NSError *error) {
		@strongify(self);
		NSLog(@"login: %@", error);
//		NSString *description = error.localizedDescription;
		
		// Replace username/email parameter
//		NSString *field = (self.isEnteringEmail) ? @"Email" : @"Username";
//		description = [description stringByReplacingOccurrencesOfString:kErrorReplaceSubstring withString:field];
//		
//		FWStatusTuple *status = [[FWStatusTuple networkError:description] withSender:self.executeLogin];
//		[webServiceSignal sendNext:status];
	}];
	
	return webServiceSignal;
}

- (RACSignal *)login {
	return [BSTParseAPIClient loginUser:self.username password:self.password];
}


@end
