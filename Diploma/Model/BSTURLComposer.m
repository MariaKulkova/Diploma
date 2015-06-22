//
//  BSTURLComposer.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTURLComposer.h"
#import "BSTServiceConstants.h"

@implementation BSTURLComposer

+ (NSURL *)constructURL:(NSString *)path {
	return [self serviceURL:PARSE_API_VERSION, path, nil];
}

+ (NSURL *)serviceURL:(NSString *)parameters, ... NS_REQUIRES_NIL_TERMINATION {
	if (parameters == nil) {
		return nil;
	}
	
	NSString *component;
	va_list argumentList;
	
	// Add first component
	NSURL *url = [[self baseURL] URLByAppendingPathComponent:parameters];
	
	// Add other components
	va_start(argumentList, parameters);
	while ((component = va_arg(argumentList, NSString *))) {
		url = [url URLByAppendingPathComponent:component];
	}
	va_end(argumentList);
	
	NSLog(@"%@", url);
	
	return url;
}

+ (NSURL *)baseURL {
	return [NSURL URLWithString:[@"http://" stringByAppendingString:PARSE_BASE_URL]];
}

@end
