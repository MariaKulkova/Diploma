//
//  BSTAim.m
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAim.h"
#import "BSTStep.h"
#import "BSTCategory.h"
#import "MagicalRecord+Additions.h"


@implementation BSTAim

@dynamic id;
@dynamic title;
@dynamic completed;
@dynamic category;
@dynamic steps;
@dynamic timeStatistics;

@end

@implementation BSTAim (Fill)

- (void)fillWithUserInfo:(NSDictionary *)info {
	self.title = info[@"title"];

	//self.category = ;
}

@end