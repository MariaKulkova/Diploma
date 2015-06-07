//
//  BSTAim.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BSTManagedObject.h"

@class BSTStep, BSTCategory, BSTStatistics;

@interface BSTAim : BSTManagedObject

@property (nonatomic)         int64_t     id;
@property (nonatomic, retain) NSString    *title;
@property (nonatomic)         BOOL        *completed;

@property (nonatomic)         BSTCategory *category;
@property (nonatomic, retain) NSSet       *steps;
@property (nonatomic, retain) NSSet       *timeStatistics;
@end

@interface BSTAim (CoreDataGeneratedAccessors)

- (void)addStepsObject:(BSTStep *)value;
- (void)removeStepsObject:(BSTStep *)value;
- (void)addSteps:(NSSet *)values;
- (void)removeSteps:(NSSet *)values;

- (void)addTimeStatisticsObject:(BSTStatistics *)value;
- (void)removeTimeStatisticsObject:(BSTStatistics *)value;
- (void)addTimeStatistics:(NSSet *)values;
- (void)removeTimeStatistics:(NSSet *)values;

@end
