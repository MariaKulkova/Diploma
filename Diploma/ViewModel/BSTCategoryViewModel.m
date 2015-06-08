//
//  BSTCategoryViewModel.m
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTCategoryViewModel.h"
#import "BSTCategory.h"
#import "Macroses.h"

@interface BSTCategoryViewModel ()

@property (nonatomic, strong) NSArray *categories;

@end

@implementation BSTCategoryViewModel

#pragma mark Init

- (void)initialize {
	self.context = [[NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_defaultContext]] listenChangesFromParentContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	
	self.categories = [BSTCategory MR_findAllSortedBy:Key(BSTCategory, title) ascending:YES inContext:self.context.parentContext];
}

#pragma mark Private

- (void)reloadCategories {
	self.categories = [BSTCategory MR_findAllSortedBy:Key(BSTCategory, title) ascending:YES inContext:self.context];
}

#pragma mark - Public

- (void)saveChanges {
	NSLog(@"Save to persistent storage");
	[self.context MR_saveToPersistentStoreAndWait];
}

- (void)rollbackChanges {
	[self.context rollback];
}

- (void)addCategory:(NSDictionary *)categoryInfo {
	BSTCategory *category = [BSTCategory MR_createInContext:self.context];
	[category fillWithUserInfo:categoryInfo];
	[self saveChanges];
	self.categories = [BSTCategory MR_findAllSortedBy:Key(BSTCategory, title) ascending:YES inContext:self.context.parentContext];
}

@end
