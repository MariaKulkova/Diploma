//
//  BSTAchievementCore.h
//  Diploma
//
//  Created by Maria on 23.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTAchievementCore : NSObject

+ (instancetype)sharedInstance;

- (void)aimAdded;

- (void)stepAdded;

- (void)stepCompleted;

- (void)aimCompleted;

@end
