//
//  BSTStep.m
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTStep.h"


@implementation BSTStep

@dynamic achieved;
@dynamic deadline;
@dynamic title;
@dynamic aim;
@dynamic reminder;

@end

@implementation BSTStep (Fill)

- (void)fillWithUserData:(NSDictionary *)info {
	self.title = info[@"title"];
	self.achieved = [info[@"achieved"] boolValue];
}

- (NSDictionary *)representInfo {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	[dictionary setValue:self.title forKey:@"title"];
	[dictionary setValue:[NSNumber numberWithBool:self.achieved] forKey:@"achieved"];
	
	return dictionary;
}

@end