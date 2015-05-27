//
//  BSTUser.m
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTUser.h"
#import "MagicalRecord+Additions.h"
#import "nsuserdefaults-macros.h"
#import "Macroses.h"


@implementation BSTUser

@dynamic email;
@dynamic username;

@dynamic categories;
@dynamic achievements;

@end

@implementation BSTUser (Custom)

+ (instancetype)currentUser {
	return [self currentUserInContext:[NSManagedObjectContext MR_defaultContext]];
}

+ (instancetype)currentUserInContext:(NSManagedObjectContext *)context {
	NSString *name = defaults_object(@"name");
	return (name) ? [BSTUser MR_findFirstByAttribute:Key(BSTUser, username) withValue:name inContext:context] : nil;
}

@end

@implementation BSTUser (Fill)

- (void)fillWithUserData:(NSDictionary *)info {
}

@end
