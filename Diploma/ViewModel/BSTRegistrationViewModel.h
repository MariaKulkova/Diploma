//
//  BSTRegistrationViewModel.h
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTRegistrationViewModel : BSTViewModel

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

@property (assign, nonatomic) BOOL completionState;

@property (strong, nonatomic) RACCommand *executeRegistration;

@end
 