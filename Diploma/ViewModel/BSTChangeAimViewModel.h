//
//  BSTChangeAimViewModel.h
//  Diploma
//
//  Created by Maria on 19.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import "MagicalRecord+Additions.h"
#import "BSTCategory.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTChangeAimViewModel : BSTViewModel

@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong, readonly) NSArray *categories;

/// Aim properties
@property (nonatomic, strong) NSString    *objectId;
@property (nonatomic, strong) BSTCategory *selectedCategory;
@property (nonatomic, strong) NSString    *aimTitle;

/// Comands for Save and Cancel
@property (nonatomic, strong) RACCommand *executeAimChanging;

- (void)saveChanges;
- (void)rollbackChanges;

@end
