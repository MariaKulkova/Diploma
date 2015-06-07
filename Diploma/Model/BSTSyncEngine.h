//
//  BSTSyncEngine.h
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTSyncEngine : NSObject

@property (nonatomic, strong, readonly) RACCommand *fetchData;
@property (nonatomic, strong, readonly) RACCommand *syncData;

+ (instancetype)sharedInstance;

@end
