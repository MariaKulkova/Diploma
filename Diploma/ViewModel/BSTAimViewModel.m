//
//  BSTAimViewModel.m
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAimViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Macroses.h"
#import "BSTAim.h"
#import "BSTStep.h"

@interface BSTAimViewModel ()

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *aims;

@end

@implementation BSTAimViewModel

#pragma mark Init

- (void)initialize {
	self.context = [NSManagedObjectContext MR_defaultContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	
	[self updateData];
	if (self.categories.count != 0) {
		self.selectedCategory = self.categories[0];
	}

	@weakify(self);
	[RACObserve(self, selectedCategory) subscribeNext:^(BSTCategory *category) {
		@strongify(self);
		self.aims = [category.aims sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:Key(BSTAim, title) ascending:YES]]];
	}];
}

#pragma mark - Public

- (void)saveChanges {
	NSLog(@"Save to persistent storage");
	[self.context MR_saveToPersistentStoreAndWait];
}

- (void)rollbackChanges {
	[self.context rollback];
}

- (void)updateData {
	self.aims = [self.selectedCategory.aims sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:Key(BSTAim, title) ascending:YES]]];
	self.categories = [BSTCategory MR_findAllSortedBy:Key(BSTCategory, title) ascending:YES inContext:self.context];
}

- (void)deleteAim:(BSTAim *)aim {
	[aim.category removeAimsObject:aim];
	for (BSTStep *step in aim.steps) {
		[step MR_deleteEntity];
	}
	[aim MR_deleteEntity];
	[self saveChanges];
	[self updateData];
}

@end
