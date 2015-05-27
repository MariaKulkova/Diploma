//
//  BSTRewarding.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BSTAchievemnt, BSTUser;

@interface BSTRewarding : NSManagedObject

@property (nonatomic, retain) BSTAchievemnt *achievement;
@property (nonatomic, retain) BSTUser       *owner;

@end
