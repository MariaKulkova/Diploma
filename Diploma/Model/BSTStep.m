//
//  BSTStep.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTStep.h"
#import "BSTAim.h"
#import "Macroses.h"


@implementation BSTStep

@dynamic id;
@dynamic achieved;
@dynamic deadline;
@dynamic title;
@dynamic aim;
@dynamic reminder;

@end

@implementation BSTStep (Fill)

- (void)fillWithUserData:(NSDictionary *)info {
	self.id    = info[@"objectId"];
	self.title = info[@"title"];
	self.achieved = [info[@"achieved"] boolValue];
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
	self.deadline = [dateFormat dateFromString:info[@"deadline"]];
	
	self.aim = [BSTAim findFirstOrCreateByAttribute:Key(BSTAim, id) withValue:info[@"aimId"] inContext:self.managedObjectContext];
}

- (NSDictionary *)representInfo {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	[dictionary setValue:self.title forKey:@"title"];
	[dictionary setValue:[NSNumber numberWithBool:self.achieved] forKey:@"achieved"];
	
	return dictionary;
}

@end