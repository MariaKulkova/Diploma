//
//  BSTAimViewModel.h
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTViewModel.h"

@interface BSTAimViewModel : BSTViewModel

@property (nonatomic, strong, readonly) NSMutableArray *categories;
@property (nonatomic, strong, readonly) NSArray *aims;

@property (nonatomic, strong) NSString *selectedCategory;

/// Weak singleton
+ (instancetype)currentInstance;
+ (instancetype)sharedInstance;

@end
