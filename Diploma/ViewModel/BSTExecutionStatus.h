//
//  BSTExecutionStatus.h
//  Diploma
//
//  Created by Maria on 29.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BSTOperationStatus){
	BSTOperationStatusNormal,
	BSTOperationStatusError,
	BSTOperationStatusCompleted,
	BSTOperationStatusHint
};

@interface BSTExecutionStatus : NSObject

@property (nonatomic, assign) BSTOperationStatus status;
@property (nonatomic, strong) NSString *statusDescription;
@property (nonatomic, weak)   id       sender;

+ (instancetype)normal;
+ (instancetype)completed;
+ (instancetype)error:(NSString *)error;
+ (instancetype)hint:(NSString *)hint;

- (instancetype)initWithStatus:(BSTOperationStatus)status;
- (instancetype)withSender:(id)sender;

- (BOOL)isHint;
- (BOOL)isError;
- (BOOL)isCompleted;
- (BOOL)isNormal;

@end
