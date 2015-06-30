//
//  BSTResetPassViewModel.h
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import "BSTExecutionStatus.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface BSTResetPassViewModel : BSTViewModel

@property (strong, nonatomic) NSString *email;

@property (nonatomic, strong) RACCommand *executePassReset;
@property (nonatomic, strong) BSTExecutionStatus *executionStatus;

@end
