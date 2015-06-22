//
//  BSTCategory.m
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTCategory.h"
#import "BSTAim.h"
#import "BSTUser.h"
#import "Macroses.h"


@implementation BSTCategory

@dynamic id;
@dynamic title;
@dynamic aims;
@dynamic owner;

- (void)fillWithUserInfo:(NSDictionary *)info {
	self.id    = info[@"objectId"];
	self.title = info[@"title"];
	if (info[@"owner"]) {
		self.owner = [BSTUser MR_findFirstByAttribute:Key(BSTUser, id) withValue:info[@"owner"] inContext:self.managedObjectContext];
	}
}

- (NSDictionary *)representInfo {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	[dictionary setValue:self.title forKey:@"title"];
	return dictionary;
}

+ (NSString *)className {
	return @"Category";
}

@end
