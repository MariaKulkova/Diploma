//
//  BSTReminder.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BSTManagedObject.h"

@class BSTPeriod, BSTStep;

@interface BSTReminder : BSTManagedObject

@property (nonatomic, retain) NSDate    *date;
@property (nonatomic)         BOOL      activated;

@property (nonatomic, retain) BSTStep   *step;
@property (nonatomic, retain) BSTPeriod *period;

@end
