//
//  BSTStepViewModel.h
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import "MagicalRecord+Additions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BSTAim.h"

@interface BSTStepViewModel : BSTViewModel

@property (nonatomic, strong, readonly) NSArray *steps;
@property (nonatomic, strong)           BSTAim  *selectedAim;

- (void)updateData;
- (void)deleteStep:(BSTStep *)step;
- (void)completeStep: (BSTStep *)step;

@end
