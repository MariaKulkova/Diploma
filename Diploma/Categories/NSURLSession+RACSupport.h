//
//  NSURLSession+RACSupport.h
//  Diploma
//
//  Created by Maria on 04.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NSURLSession (RACSupport)

/**
 *  Subscribe on this signal, if you need to process response headers
 */
@property (nonatomic, strong, readonly) RACSubject *responseListener;

- (RACSignal *)rac_signalWithRequest:(NSURLRequest *)request;
- (RACSignal *)rac_getDataAtURL:(NSURL *)url;
- (RACSignal *)rac_postData:(NSDictionary *)data atUrl:(NSURL *)url;
- (RACSignal *)rac_deleteData:(NSDictionary *)data atUrl:(NSURL *)url;
- (RACSignal *)rac_patchData:(NSDictionary *)data atUrl:(NSURL *)url;

@end
