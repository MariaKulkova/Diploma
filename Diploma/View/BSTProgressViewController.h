//
//  BSTProgressViewController.h
//  Diploma
//
//  Created by Maria on 20.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTBaseViewController.h"
#import "BSTAim.h"

@interface BSTProgressViewController : BSTBaseViewController

@property (strong, nonatomic) BSTAim *presentedAim;

- (void)reloadData;

@end
