//
//  BSTWebCore.m
//  Diploma
//
//  Created by Maria on 29.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTWebCore.h"

static NSString * const kSDFParseAPIBaseURLString = @"https://api.parse.com/1/";

static NSString * const kSDFParseAPIApplicationId = @"YOUR_APPLICATION_ID";
static NSString * const kSDFParseAPIKey = @"YOUR_REST_API_KEY";

@interface BSTWebCore ()

@property (nonatomic, strong) NSDictionary *parseAuthHeaders;

@end

@implementation BSTWebCore

#pragma mark - Init

+ (instancetype)sharedInstance {
	static BSTWebCore *sharedInstance = nil;
	static dispatch_once_t once_token = 0;
	
	dispatch_once(&once_token, ^{
		sharedInstance = [[self class] new];
	});
	
	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		[self initialize];
	}
	return self;
}

- (void)initialize {
	NSMutableDictionary *headersDictionary = [[NSMutableDictionary alloc] init];
	[headersDictionary setValue:kSDFParseAPIApplicationId forKey:@"X-Parse-Application-Id"];
	[headersDictionary setValue:kSDFParseAPIKey forKey:@"X-Parse-REST-API-Key"];
	self.parseAuthHeaders = [NSDictionary dictionaryWithDictionary:headersDictionary];
}

+ (NSURLSession *)sharedSession {
	return [[self sharedInstance] sharedSession];
}


- (NSURLSessionConfiguration *)defaultConfiguration {
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	configuration.HTTPAdditionalHeaders = self.parseAuthHeaders;
	return configuration;
}


@end
