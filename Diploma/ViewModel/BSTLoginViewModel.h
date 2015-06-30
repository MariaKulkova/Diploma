//
//  BSTLoginViewModel.h
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import "BSTExecutionStatus.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTLoginViewModel : BSTViewModel

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) RACCommand *executeLogin;
@property (nonatomic, strong) BSTExecutionStatus *executionStatus;

@end
