//
//  BSTStep.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BSTManagedObject.h"

@class BSTAim, BSTReminder;

@interface BSTStep : BSTManagedObject

@property (nonatomic)         BOOL     achieved;
@property (nonatomic, retain) NSDate   *deadline;
@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) BSTAim      *aim;
@property (nonatomic, retain) BSTReminder *reminder;

@end
