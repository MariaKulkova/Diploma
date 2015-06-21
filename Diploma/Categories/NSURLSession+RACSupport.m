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
