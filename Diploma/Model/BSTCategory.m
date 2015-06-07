//
//  BSTCategory.m
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTCategory.h"
#import "BSTAim.h"
#import "BSTUser.h"


@implementation BSTCategory

@dynamic id;
@dynamic title;
@dynamic aims;
@dynamic owner;

@end

@implementation BSTCategory (Fill)

- (void)fillWithUserInfo:(NSDictionary *)info {
	self.id = [info[@"id"] longLongValue];
	self.title = info[@"title"];
	self.aims  = info[@"aims"];
}

- (NSDictionary *)representInfo {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	[dictionary setValue:self.objectID forKey:@"id"];
	[dictionary setValue:self.title forKey:@"title"];
	[dictionary setValue:self.aims forKey:@"aims"];
	[dictionary setValue:self.owner.objectID forKey:@"owner_id"];

	return dictionary;
}

@end