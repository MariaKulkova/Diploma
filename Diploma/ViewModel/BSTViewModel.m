//
//  BSTViewModel.m
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"

@implementation BSTViewModel

#pragma mark - Init

- (instancetype)init {
	if (self = [super init]) {
		[self initialize];
	}
	return self;
}

- (void)initialize {
}

- (void)dealloc {
	[NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)saveChanges {
	NSLog(@"Save to persistent storage");
	[self.context MR_saveToPersistentStoreAndWait];
}

- (void)rollbackChanges {
	[self.context rollback];
}

@end
