//
//  BSTNotificationsManager.h
//  Diploma
//
//  Created by Maria on 23.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSTNotificationsManager : NSObject

+ (instancetype)sharedInstance;

- (void)addNotification:(UILocalNotification *)notification;
- (void)removeNotification:(UILocalNotification *)notification;

@end
