//
//  BSTParseAPIClient.m
//  Diploma
//
//  Created by Maria on 28.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTParseAPIClient.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTParseAPIClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation BSTParseAPIClient

- (id)init {
	if (self = [super init]) {
		NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
		_session = [NSURLSession sessionWithConfiguration:config];
	}
	return self;
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
	NSLog(@"Fetching: %@",url.absoluteString);
 
	// 1
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		// 2
		NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			if (! error) {
				NSError *jsonError = nil;
				id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
				if (!jsonError) {
					[subscriber sendNext:json];
				}
				else {
					[subscriber sendError:jsonError];
				}
			}
			else {
				[subscriber sendError:error];
			}
			[subscriber sendCompleted];
		}];
		
		[dataTask resume];
		
		return [RACDisposable disposableWithBlock:^{
			[dataTask cancel];
		}];
	}] doError:^(NSError *error) {
		NSLog(@"%@",error);
	}];
}

@end
