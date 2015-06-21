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
#import "BSTParseAPIClient.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BSTAim.h"

@interface BSTCategoryViewModel ()

@property (nonatomic, strong) NSArray *categories;

@end

@implementation BSTCategoryViewModel

#pragma mark Init

- (void)initialize {
	self.context = [NSManagedObjectContext MR_defaultContext];
//	self.context = [[NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_defaultContext]] listenChangesFromParentContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	
	self.categories = [BSTCategory MR_findAllSortedBy:Key(BSTCategory, title) ascending:YES inContext:self.context];
}

- (void)deleteCategory:(BSTCategory *)category {
	for (BSTAim *aim in category.aims) {
		[aim MR_deleteEntity];
	}
	[category MR_deleteEntity];
	[self saveChanges];
	[self updateData];
}

#pragma mark Private

- (void)updateData {
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

@end
