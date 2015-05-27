//
//  BSTReminder.m
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTReminder.h"
#import "BSTPeriod.h"
#import "BSTStep.h"


@implementation BSTReminder

@dynamic date;
@dynamic activated;
@dynamic step;
@dynamic period;

@end

@implementation BSTReminder (Fill)

- (void)fillWithUserData:(NSDictionary *)info {
}

@end