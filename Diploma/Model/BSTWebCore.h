//
//  BSTWebCore.h
//  Diploma
//
//  Created by Maria on 29.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>

@interface BSTWebCore : NSObject

@property (nonatomic, strong, readonly) NSURLSession *parseSession;

@property (nonatomic, strong, readonly) RACSignal *isAuthorized;

+ (instancetype)sharedInstance;

+ (NSURLSession *)parseSession;

@end
