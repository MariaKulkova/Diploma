//
//  BSTReminder.h
//  Diploma
//
//  Created by Maria on 22.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BSTStep;

@interface BSTReminder : NSManagedObject

@property (nonatomic, retain) NSString *id;
@property (nonatomic, assign) BOOL      activated;
@property (nonatomic, retain) NSDate   *date;
@property (nonatomic, assign) int64_t   period;
@property (nonatomic, retain) BSTStep  *step;

@end
