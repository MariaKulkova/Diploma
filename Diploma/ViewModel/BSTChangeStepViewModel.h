//
//  BSTChangeStepViewModel.h
//  Diploma
//
//  Created by Maria on 21.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import "BSTAim.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTChangeStepViewModel : BSTViewModel

/// Step properties
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) BSTAim   *selectedAim;
@property (nonatomic, strong) NSString *stepTitle;
@property (nonatomic, strong) NSDate   *date;

/// Comands for Save and Cancel
@property (nonatomic, strong) RACCommand *executeStepChanging;

@end
