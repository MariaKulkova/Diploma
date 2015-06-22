//
//  BSTAim.m
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAim.h"
#import "BSTCategory.h"
#import "BSTStatistics.h"
#import "BSTStep.h"
#import "Macroses.h"


@implementation BSTAim

@dynamic id;
@dynamic completed;
@dynamic title;
@dynamic stepsCount;
@dynamic stepsCompleted;
@dynamic category;
@dynamic steps;
@dynamic timeStatistics;

@end

@implementation BSTAim (Fill)

- (void)fillWithUserInfo:(NSDictionary *)info {
	self.id        = info[@"objectId"];
	self.title     = info[@"title"];
	self.completed = [info[@"achieved"] boolValue];
	self.category  = [BSTCategory findFirstOrCreateByAttribute:Key(BSTCategory, id) withValue:info[@"categoryId"] inContext:self.managedObjectContext];
}

- (NSDictionary *)representInfo {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	[dictionary setValue:self.title forKey:@"title"];
	[dictionary setValue:[NSNumber numberWithLongLong:self.stepsCount] forKey:@"steps_count"];
	[dictionary setValue:[NSNumber numberWithLongLong:self.stepsCompleted] forKey:@"steps_completed"];
	
	return dictionary;
}

- (NSInteger)getCompletedStepsCount {
	NSInteger count = 0;
	for (BSTStep *step in self.steps) {
		if (step.achieved) {
			count++;
		}
	}
	return count;
}

@end
