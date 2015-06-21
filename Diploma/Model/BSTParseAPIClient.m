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

@end
