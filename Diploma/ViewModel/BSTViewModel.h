//
//  BSTViewModel.h
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicalRecord+Additions.h"

@interface BSTViewModel : NSObject

@property (strong, nonatomic) NSManagedObjectContext *context;

// Custom initializer for all instances created with `alloc/init` and `new`
- (void)initialize;

- (void)saveChanges;
- (void)rollbackChanges;

@end
