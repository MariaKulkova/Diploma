//
//  BSTCategory.h
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BSTManagedObject.h"

@class BSTAim, BSTUser;

@interface BSTCategory : BSTManagedObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSSet    *aims;
@property (nonatomic, retain) BSTUser  *owner;
@end

@interface BSTCategory (CoreDataGeneratedAccessors)

- (void)addAimsObject:(BSTAim *)value;
- (void)removeAimsObject:(BSTAim *)value;
- (void)addAims:(NSSet *)values;
- (void)removeAims:(NSSet *)values;

@end
