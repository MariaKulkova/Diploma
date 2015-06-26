//
//  BSTChangeCategoryViewModel.h
//  Diploma
//
//  Created by Maria on 20.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MagicalRecord+Additions.h"

@interface BSTChangeCategoryViewModel : BSTViewModel

/// Aim properties
@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *categoryTitle;

/// Comands for Save and Cancel
@property (nonatomic, strong) RACCommand *executeCategoryChanging;

@end
