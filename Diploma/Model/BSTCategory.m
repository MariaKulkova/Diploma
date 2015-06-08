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

@dynamic title;
@dynamic aims;
@dynamic owner;

- (void)fillWithUserInfo:(NSDictionary *)info {
	self.title = info[@"title"];
	
	NSMutableSet *deprecated = [self.aims mutableCopy];
	for (NSDictionary *aimInfo in info[@"aims_id"]) {
		// Found existing or create empty
		BSTAim *aim = [BSTAim findFirstOrCreateByAttribute:Key(BSTAim, objectID) withValue:aimInfo[@"aims_id"] inContext:self.managedObjectContext];
		[aim fillWithUserInfo:aimInfo];
		
		[self addAimsObject:aim];
		[deprecated removeObject:aim];
	}
	[self deprecateEntities:deprecated];
}

- (NSDictionary *)representInfo {
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	[dictionary setValue:self.title forKey:@"title"];
	return dictionary;
}

@end
