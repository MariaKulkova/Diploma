//
//  BSTParseAPIClient.m

//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTParseAPIClient.h"
#import "BSTWebCore.h"
#import "BSTURLComposer.h"
#import "BSTServiceConstants.h"
#import "NSURLSession+RACSupport.h"

@interface BSTParseAPIClient ()

@end

@implementation BSTParseAPIClient

+ (RACSignal *)addObject:(BSTManagedObject *)object {
	return [[[BSTWebCore.parseSession
			  	rac_postData:[object representInfo]
			  	atUrl:[BSTURLComposer serviceURL:PARSE_API_VERSION, kServiceObject, [[object class] className], nil]]
			 	deliverOnMainThread]
				doNext:^(NSDictionary *answer) {
					NSLog(@"%@", answer);
				}];
}

+ (RACSignal *)loginUser:(NSString *)value password:(NSString *)password {
	NSDictionary *loginData = @{@"username": value, @"password": password};
	NSString *fullAddressURL = [NSString stringWithFormat:@"http://api.parse.com/1/login?username=%@&password=%@", value, password];
	fullAddressURL = [fullAddressURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"fullAddressURL: %@",fullAddressURL);
	
	NSURL *url = [NSURL URLWithString:fullAddressURL];
	
	return [[[BSTWebCore.parseSession
			rac_postData:loginData
			atUrl:url]
			deliverOnMainThread]
			doNext:^(NSDictionary *authInfo) {
				NSLog(@"%@", authInfo);
			}];
}

@end
