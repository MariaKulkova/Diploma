//
//  BSTAddStepViewController.h
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTBaseViewController.h"
#import "BSTStep.h"

@interface BSTAddStepViewController : BSTBaseViewController

@property (strong, nonatomic) BSTStep *selectedStep;
@property (strong, nonatomic) BSTAim  *selectedAim;

@end
