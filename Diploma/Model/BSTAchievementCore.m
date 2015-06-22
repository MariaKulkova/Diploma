//
//  BSTAchievementCore.m
//  Diploma
//
//  Created by Maria on 23.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAchievementCore.h"
#import <UIKit/UIKit.h>

@interface BSTAchievementCore ()

@property (assign, nonatomic) NSInteger aimsCount;
@property (assign, nonatomic) NSInteger stepsCount;
@property (assign, nonatomic) NSInteger completedSteps;
@property (assign, nonatomic) NSInteger completedAims;

@end

@implementation BSTAchievementCore

+ (instancetype)sharedInstance {
	static BSTAchievementCore *sharedInstance = nil;
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


- (void)aimAdded {
	self.aimsCount++;
}

- (void)stepAdded {
	self.stepsCount++;
	
}

- (void)stepCompleted {
	self.completedSteps++;
	if (self.completedSteps == 1) {
		UILocalNotification* localNotification = [[UILocalNotification alloc] init];
		localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:3];
		localNotification.alertBody = @"Congratuations! Your firt completed step!";
		localNotification.timeZone = [NSTimeZone defaultTimeZone];
		localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
		
		[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
	}
}

@end
