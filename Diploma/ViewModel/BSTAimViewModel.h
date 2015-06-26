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
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTAimViewModel : BSTViewModel

@property (nonatomic, strong, readonly) NSArray *categories;
@property (nonatomic, strong, readonly) NSArray *aims;

@property (nonatomic, strong) BSTCategory *selectedCategory;

- (void)updateData;
- (void)deleteAim:(BSTAim *)aim;

@end
