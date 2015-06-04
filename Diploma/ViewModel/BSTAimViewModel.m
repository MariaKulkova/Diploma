//
//  BSTAimViewModel.m
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAimViewModel.h"

@interface BSTAimViewModel ()

@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSArray *aims;

@end

@implementation BSTAimViewModel

#pragma mark Init

/// Weak delegate
static __weak BSTAimViewModel *instance;

+ (instancetype)currentInstance {
	id strongInstance = instance;
	return strongInstance;
}

+ (id)sharedInstance {
	id strongInstance = instance;
	@synchronized(self) {
		if (strongInstance == nil) {
			strongInstance = [[self class] new];
			instance = strongInstance;
		}
	}
	return strongInstance;
}

- (void)initialize {
	[super initialize];
}

@end
