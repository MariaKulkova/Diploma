//
//  BSTStatistics.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BSTManagedObject.h"

@class BSTAim;

@interface BSTStatistics : BSTManagedObject

@property (nonatomic)         int64_t trackedTime;

@property (nonatomic, retain) NSDate  *date;
@property (nonatomic, retain) BSTAim  *aim;

@end
