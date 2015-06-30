//
//  BSTExecutionStatus.m
//  Diploma
//
//  Created by Maria on 29.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTExecutionStatus.h"

@implementation BSTExecutionStatus

+ (instancetype)normal {
	return [[BSTExecutionStatus alloc] initWithStatus:BSTOperationStatusNormal];
}

+ (instancetype)completed {
	return [[BSTExecutionStatus alloc] initWithStatus:BSTOperationStatusCompleted];
}

+ (instancetype)error:(NSString *)error {
	BSTExecutionStatus *status = [[BSTExecutionStatus alloc] initWithStatus:BSTOperationStatusError];
	status.statusDescription = error;
	return status;
}

+ (instancetype)hint:(NSString *)hint {
	BSTExecutionStatus *status = [[BSTExecutionStatus alloc] initWithStatus:BSTOperationStatusHint];
	status.statusDescription = hint;
	return status;
}

- (instancetype)init {
	if (self = [super init]) {
		self.status = BSTOperationStatusNormal;
	}
	return self;
}

- (instancetype)initWithStatus:(BSTOperationStatus)status {
	if (self = [self init]) {
		self.status = status;
	}
	return self;
}

- (instancetype)withSender:(id)sender {
	self.sender = sender;
	return self;
}

- (BOOL)isNormal {
	return self.status == BSTOperationStatusNormal;
}

- (BOOL)isCompleted {
	return self.status == BSTOperationStatusCompleted;
}

- (BOOL)isError {
	return self.status == BSTOperationStatusError;
}

- (BOOL)isHint {
	return self.status == BSTOperationStatusHint;
}

@end
