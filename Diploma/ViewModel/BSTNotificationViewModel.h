//
//  BSTNotificationViewModel.h
//  Diploma
//
//  Created by Maria on 22.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import "BSTStep.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BSTReminder.h"

@interface BSTNotificationViewModel : BSTViewModel

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) BSTStep  *selectedStep;
@property (nonatomic, assign) BOOL      activated;
@property (nonatomic, assign) NSInteger period;
@property (nonatomic, strong) NSDate   *date;

/// Comands for Save and Cancel
@property (nonatomic, strong) RACCommand *executeNotificationChanging;

@end
