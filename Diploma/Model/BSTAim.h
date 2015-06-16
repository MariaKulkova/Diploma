//
//  BSTAim.h
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BSTManagedObject.h"

@class BSTCategory, BSTStatistics, BSTStep;

@interface BSTAim : BSTManagedObject

@property (nonatomic) NSString *id;
@property (nonatomic) BOOL      completed;
@property (nonatomic) int64_t   stepsCount;
@property (nonatomic) int64_t   stepsCompleted;
@property (nonatomic, retain)   NSString *title;

@property (nonatomic, retain) BSTCategory *category;
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
