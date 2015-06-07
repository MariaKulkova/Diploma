//
//  NSURLSession+RACSupport.m
//  Diploma
//
//  Created by Maria on 04.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "NSURLSession+RACSupport.h"
#import "objc/runtime.h"

@implementation NSURLSession (RACSupport)

static NSString * const kHTTPMethodGET    = @"GET";
static NSString * const kHTTPMethodPOST   = @"POST";
static NSString * const kHTTPMethodDELETE = @"DELETE";
static NSString * const kHTTPMethodPATCH  = @"PATCH";

#pragma mark - Private

//- (NSString *)parseErrorResponse:(NSHTTPURLResponse *)response withData:(id)json {
//	NSString *host = response.URL.host;
//	NSString *description;
//	
//	if ([host isEqualToString:kFanwireHost]) {
//		description = [self parseFanwireError:nil withResponse:response withData:json];
//	}
//	else if ([host isEqualToString:FACEBOOK_HOST]) {
//		description = json[@"error"][@"message"];
//	}
//	else if ([host isEqualToString:TWITTER_HOST]) {
//		description = [json[@"errors"] firstObject][@"message"];
//	}
//	else if ([host isEqualToString:INSTAGRAM_HOST]) {
//		description = json[@"meta"][@"error_message"];
//	}
//	else if ([host isEqualToString:GOOGLE_HOST]) {
//		description = json[@"error"][@"message"];
//	}
//	else {
//		description = [@"Unknown error host: " stringByAppendingString:host];
//		DLog(@"%@", description);
//	}
//	
//	if (!description) {
//		description = [NSString stringWithFormat:@"Error parsing failed: [%ld] %@", (long)response.statusCode, host];
//		DLog(@"%@ %@ %@", response.URL.absoluteString, json, response.allHeaderFields);
//	}
//	
//	return description;
//}
//
//- (NSString *)parseFanwireError:(NSError *)error withResponse:(NSHTTPURLResponse *)response withData:(id)json {
//	NSString *description;
//	NSString *fallback;
//	// Error keys: 'code_field_reason', 'code_reason', just 'code', etc.
//	NSMutableArray *keys = [NSMutableArray array];
//	
//	// Code
//	NSString *errorCode = @(response ? response.statusCode : error.code).stringValue;
//	[keys addObject:errorCode];
//	
//	// All errors will be delivered inside 'errors' object
//	json = ([json isKindOfClass:[NSDictionary class]]) ? json[@"errors"] : nil;
//	
//	if ([json isKindOfClass:[NSString class]]) {
//		// Reason
//		[keys addObject:[json lowercaseString]];
//		fallback = json;
//	}
//	else if ([json isKindOfClass:[NSDictionary class]]) {
//		NSString *field  = [[json allKeys] firstObject];
//		NSString *reason = [json[field] firstObject];
//		// Field + reason
//		[keys addObject:[field lowercaseString]];
//		[keys addObject:[reason lowercaseString]];
//		fallback = reason;
//	}
//	else if ([json isKindOfClass:[NSArray class]]) {
//		// Reason
//		NSString *reason = [json firstObject];
//		[keys addObject:[reason lowercaseString]];
//		fallback = reason;
//	}
//	
//	// Specify method. Filter '/api/v1/' prefix from url.path
//	const NSUInteger loc = 3;
//	NSArray *components = response.URL.pathComponents;
//	components = [components subarrayWithRange:NSMakeRange(loc, components.count - loc)];
//	NSString *method = [components componentsJoinedByString:@"/"];
//	
//	// Get error description from plist-file
//	NSString * const kDefaultErrors = @"*";
//	NSDictionary *errorStorage = [NSDictionary dictionaryWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"ServerErrorList" withExtension:@"plist"]];
//	NSDictionary *defaultDescriptions = errorStorage[kDefaultErrors];
//	NSDictionary *errorDescriptions   = errorStorage[method];
//	
//	// storage[method/*][key/code]
//	
//	NSMutableArray *errorKeys = [NSMutableArray arrayWithCapacity:(keys.count + 1)];
//	for (NSUInteger i = 0; i < keys.count; ++i) {
//		NSString *key = keys[i];
//		if (i > 0) {
//			key = [errorKeys[i-1] stringByAppendingFormat:@"_%@", key];
//		}
//		[errorKeys addObject:key];
//	}
//	
//	[errorKeys insertObject:kDefaultErrors atIndex:0];
//	
//	for (NSString *key in [errorKeys reverseObjectEnumerator]) {
//		description = errorDescriptions[key] ?: defaultDescriptions[key];
//		if (description) {
//			DLog(@"Pick error description for key <%@> by keys %@", key, errorKeys);
//			break;
//		}
//	}
//	
//	if (description) {
//		// Replace different format specifiers in description
//		description = [description stringByReplacingOccurrencesOfString:@"%c" withString:errorCode options:0 range:description.range];
//	} else {
//		DLog(@"Description not found for method <%@> by keys %@", method, errorKeys);
//		description = fallback;
//	}
//	
//	return description;
//}

- (RACSignal *)rac_signalWithRequest:(NSURLRequest *)request {
	@weakify(self);
	return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		@strongify(self);
		NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
			@strongify(self);
			// Notify response listener
			[self.responseListener sendNext:response];
			
			// Get HTTP code and HTTP code family
			NSInteger httpStatusCode       = [(NSHTTPURLResponse *)response statusCode];
			NSInteger httpStatusCodeFamily = httpStatusCode / 100;
			
			// Parse response anyway, because we may have error description
			id parsedObject;
			if (data.length > 0) {
				NSError *parseError = nil;
				parsedObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
				if (parseError) {
					[subscriber sendError:parseError];
				}
			}
			
			// Now process all source data
//			if (!error && httpStatusCodeFamily == HTTPCode2XXSuccessUnknown) {
//				[subscriber sendNext:parsedObject];
//			}
//			else if (error) {
//				DLog(@"FAIL: %@ %@", request.HTTPMethod, request.URL.absoluteString);
//				NSString *description = [self parseFanwireError:error withResponse:(NSHTTPURLResponse *)response withData:parsedObject];
//				error = [NSError errorWithDomain:error.domain code:error.code userInfo:@{NSLocalizedDescriptionKey:description}];
//				[subscriber sendError:error];
//			}
//			else {
//				NSString *description = [self parseErrorResponse:(NSHTTPURLResponse *)response withData:parsedObject];
//				NSError *error = [NSError errorWithDomain:kErrorDomain code:httpStatusCode userInfo:@{NSLocalizedDescriptionKey:description}];
//				[subscriber sendError:error];
//			}
			
			[subscriber sendCompleted];
		}];
		
		//registerNetworkTask(YES);
		[task resume];
		
		return [RACDisposable disposableWithBlock:^{
			if (task.state != NSURLSessionTaskStateCompleted) {
				[task cancel];
			}
			//registerNetworkTask(NO);
		}];
	}];
}

- (RACSignal *)performRequestWithURL:(NSURL *)url HTTPMethod:(NSString *)httpMethod data:(NSDictionary *)data  {
	NSCParameterAssert(httpMethod != nil);
	NSCParameterAssert(url != nil);
	
	@weakify(self);
	return [RACSignal defer:^RACSignal *{
		@strongify(self);
		
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
		request.allHTTPHeaderFields = self.configuration.HTTPAdditionalHeaders;
		request.HTTPMethod = httpMethod;
		
		if (data) {
			NSError *jsonParseError;
			NSData *rawData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:&jsonParseError];
			NSCParameterAssert(jsonParseError == nil);
			
			request.HTTPBody = rawData;
		}
		
		return [self rac_signalWithRequest:request];
	}];
}

#pragma mark - Public

- (RACSignal *)rac_getDataAtURL:(NSURL *)url {
	return [self performRequestWithURL:url HTTPMethod:kHTTPMethodGET data:nil];
}

- (RACSignal *)rac_postData:(NSDictionary *)data atUrl:(NSURL *)url {
	return [self performRequestWithURL:url HTTPMethod:kHTTPMethodPOST data:data];
}

- (RACSignal *)rac_deleteData:(NSDictionary *)data atUrl:(NSURL *)url {
	return [self performRequestWithURL:url HTTPMethod:kHTTPMethodDELETE data:data];
}

- (RACSignal *)rac_patchData:(NSDictionary *)data atUrl:(NSURL *)url {
	return [self performRequestWithURL:url HTTPMethod:kHTTPMethodPATCH data:data];
}

#pragma mark - Lazy Property

- (RACSubject *)responseListener {
	static char *kResponseListenerKey = "responseListener";
	
	RACSubject *alreadyExistsSignal = objc_getAssociatedObject(self, kResponseListenerKey);
	if (!alreadyExistsSignal) {
		alreadyExistsSignal = [RACSubject subject];
		objc_setAssociatedObject(self, kResponseListenerKey, alreadyExistsSignal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	
	return alreadyExistsSignal;
}


@end
