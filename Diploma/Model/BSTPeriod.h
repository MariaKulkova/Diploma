//
//  BSTPeriod.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BSTManagedObject.h"

@class BSTPeriodType, BSTReminder;

@interface BSTPeriod : BSTManagedObject

@property (nonatomic)         int64_t        periodValue;
@property (nonatomic, retain) BSTPeriodType *type;
@property (nonatomic, retain) BSTReminder   *reminder;

@end
