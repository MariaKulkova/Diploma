//
//  BSTParseClient.h
//  Diploma
//
//  Created by Maria on 26.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTParseClient : NSObject

+ (RACSignal *)signUpUser:(NSString *)username email:(NSString *)email password:(NSString *)password;

+ (RACSignal *)logInUser:(NSString *)username password:(NSString *)password;

@end
