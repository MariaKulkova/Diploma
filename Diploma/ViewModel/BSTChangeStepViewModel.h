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

@property (nonatomic, strong) NSManagedObjectContext *context;

/// Step properties
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) BSTAim   *selectedAim;
@property (nonatomic, strong) NSString *stepTitle;

/// Comands for Save and Cancel
@property (nonatomic, strong) RACCommand *executeStepChanging;

- (void)saveChanges;
- (void)rollbackChanges;
@end
