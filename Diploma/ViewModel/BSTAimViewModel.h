//
//  BSTAimViewModel.h
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTViewModel.h"
#import "MagicalRecord+Additions.h"
#import "BSTCategory.h"

@interface BSTAimViewModel : BSTViewModel

@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong, readonly) NSArray *categories;
@property (nonatomic, strong, readonly) NSArray *aims;

@property (nonatomic, strong) BSTCategory *selectedCategory;

- (void)saveChanges;
- (void)rollbackChanges;
- (void)addAim:(NSDictionary *)aimInfo intoCategory:(id)dbEntity;

@end
