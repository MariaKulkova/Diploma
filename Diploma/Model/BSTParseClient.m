//
//  BSTParseClient.m
//  Diploma
//
//  Created by Maria on 26.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTParseClient.h"

@implementation BSTParseClient

+ (RACSignal *)signUpUser:(NSString *)username email:(NSString *)email password:(NSString *)password {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		PFUser *user = [PFUser user];
		user.username = username;
		user.password = password;
		user.email = email;
		
		[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
			if (!error) {   // Hooray! Let them use the app now.
				NSLog(@"Success register user");
				[subscriber sendNext:nil];
			}
			else {
				NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
				NSLog(@"%@", errorString);
				[subscriber sendError:error];
			}
			[subscriber sendCompleted];
		}];
		
		return [RACDisposable disposableWithBlock:^{
			NSLog(@"Dispose");
		}];
	}];
}

+ (RACSignal *)logInUser:(NSString *)username password:(NSString *)password {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[PFUser logInWithUsernameInBackground:username password:password
			block:^(PFUser *user, NSError *error) {
				if (user) {
					NSLog(@"Success authorize user");
					[subscriber sendNext:nil];
				}
				else {
					[subscriber sendError:error];
				}
				[subscriber sendCompleted];
			}];
		
		return [RACDisposable disposableWithBlock:^{
			NSLog(@"Dispose");
		}];
	}];
}

+ (RACSignal *)resetPassword:(NSString *)email {
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		[PFUser requestPasswordResetForEmailInBackground:email
			block:^(BOOL succeeded, NSError *error) {
				if (!error) {
					NSLog(@"Success reset password");
					[subscriber sendNext:nil];
				}
				else {
					NSLog(@"%@", error);
					[subscriber sendError:error];
				}
				[subscriber sendCompleted];
			}];
		
		return [RACDisposable disposableWithBlock:^{
			NSLog(@"Dispose");
		}];
	}];
}

@end
