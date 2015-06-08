//
//  BSTCategoryViewModel.h
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTViewModel.h"
#import "MagicalRecord+Additions.h"

@interface BSTCategoryViewModel : BSTViewModel

@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong, readonly) NSArray *categories;

- (void)saveChanges;
- (void)rollbackChanges;
- (void)addCategory:(NSDictionary *)categoryinfo;

@end
