//
//  BSTNotificationsManager.m
//  Diploma
//
//  Created by Maria on 23.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTNotificationsManager.h"

@interface BSTNotificationsManager ()

@property (strong, nonatomic) NSMutableArray *notifications;

@end

@implementation BSTNotificationsManager

#pragma mark - Init

+ (instancetype)sharedInstance {
	static BSTNotificationsManager *sharedInstance = nil;
	static dispatch_once_t once_token = 0;
	
	dispatch_once(&once_token, ^{
		sharedInstance = [[self class] new];
	});
	
	return sharedInstance;
}

- (instancetype)init {
	if (self = [super init]) {
		[self initialize];
	}
	return self;
}

- (void)initialize {
	
}

@end
