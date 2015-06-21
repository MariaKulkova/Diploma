//
//  BSTManagedObject.h
//  Diploma
//
//  Created by Maria on 04.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MagicalRecord+Additions.h"

@interface BSTManagedObject : NSManagedObject

- (NSDictionary *)representInfo;
+ (NSString *)className;

@end

@interface BSTManagedObject (Fill)

- (void)fillWithUserInfo:(NSDictionary *)info;

@end

@interface BSTManagedObject (Custom)

+ (void)deprecateEntities:(id<NSFastEnumeration>)entities inContext:(NSManagedObjectContext *)context;
- (void)deprecateEntities:(id<NSFastEnumeration>)entities;

@end