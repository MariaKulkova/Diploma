//
//  BSTWebCore.m
//  Diploma
//
//  Created by Maria on 29.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTWebCore.h"

static NSString * const kSDFParseAPIBaseURLString = @"https://api.parse.com/1/";

static NSString * const kSDFParseAPIApplicationId = @"zaJZnPE05UW9i7Hjrle338S0geAG30m4Cj3thWhU";
static NSString * const kSDFParseAPIKey = @"1CQKgBONmElYOV1AsS2BxONFqN9MzFurl2J4CbyD";

@interface BSTWebCore ()

@property (nonatomic, strong) NSURLSession *parseSession;
@property (nonatomic, strong) NSURLSession *authorizedSession;
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
	
}

- (NSDictionary *)defaultHeaders {
	NSMutableDictionary *headersDictionary = [[NSMutableDictionary alloc] init];
	[headersDictionary setValue:@"application/json" forKey:@"Content-Type"];
//	[headersDictionary setValue:@"1" forKey:@"X-Parse-Revocable-Session"];
	[headersDictionary setValue:@"zaJZnPE05UW9i7Hjrle338S0geAG30m4Cj3thWhU" forKey:@"X-Parse-Application-Id"];
	[headersDictionary setValue:@"1CQKgBONmElYOV1AsS2BxONFqN9MzFurl2J4CbyD" forKey:@"X-Parse-REST-API-Key"];
	self.parseAuthHeaders = [NSDictionary dictionaryWithDictionary:headersDictionary];
	return headersDictionary;
}

- (NSDictionary *)authHeaders {
	NSMutableDictionary *headersDictionary = [[self defaultHeaders] mutableCopy];
//	[headersDictionary setValue:<#(id)#> forKey:@"X-Parse-Session-Token"];
	return headersDictionary;
}


/// @return Default configuration for all hosts
- (NSURLSessionConfiguration *)defaultConfiguration {
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	configuration.HTTPAdditionalHeaders = self.defaultHeaders;
	return configuration;
}

/// @return Configuration object if authorization fields was found, otherwise nil
- (NSURLSessionConfiguration *)authorizedConfiguration {
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	configuration.HTTPAdditionalHeaders = self.authHeaders;
	return configuration;
}

+ (NSURLSession *)parseSession {
	return [[self sharedInstance] parseSession];
}

- (NSURLSession *)parseSession {
	if (!_parseSession) {
		NSURLSessionConfiguration *configuration = [self defaultConfiguration];
		_parseSession = [NSURLSession sessionWithConfiguration:configuration];
	}
	return _parseSession;
}

@end
