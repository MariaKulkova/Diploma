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

@interface BSTAimViewModel ()

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *aims;

@end

@implementation BSTAimViewModel

#pragma mark Init

- (void)initialize {
	self.context = [[NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_defaultContext]] listenChangesFromParentContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	
	self.aims = [BSTAim MR_findAllSortedBy:Key(BSTAim, title) ascending:YES inContext:self.context.parentContext];
	
	@weakify(self);
	
	[RACObserve(self, categories) subscribeNext:^(NSSet *set) {
		@strongify(self);
		if (set != nil) {
			self.categories = [set sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:Key(BSTCategory, title) ascending:YES]]];
			
			if (self.selectedCategory == nil || ![self.categories containsObject:self.selectedCategory]) {
				self.selectedCategory = [self.categories firstObject];
			}
		}
	}];
	
	[RACObserve(self, selectedCategory) subscribeNext:^(BSTCategory *category) {
		@strongify(self);
		self.aims = [BSTAim MR_findAllSortedBy:Key(BSTAim, title) ascending:YES inContext:self.context.parentContext];
//		self.aims = [category.aims sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:Key(BSTAim, title) ascending:YES]]];
	}];
}

#pragma mark - Public

- (void)saveChanges {
	NSLog(@"Save to persistent storage");
	[self.context MR_saveToPersistentStoreAndWait];
	//[self.context MR_saveToPersistentStoreWithCompletion:nil];
}

- (void)rollbackChanges {
	[self.context rollback];
}

- (void)addAim:(NSDictionary *)aimInfo intoCategory:(id)dbEntity {
	BSTAim *aim = [BSTAim MR_createInContext:self.context];
	[aim fillWithUserInfo:aimInfo];
	NSArray *a = [BSTAim MR_findAllSortedBy:Key(BSTAim, title) ascending:YES inContext:self.context];
	[self saveChanges];
	self.aims = [BSTAim MR_findAllSortedBy:Key(BSTAim, title) ascending:YES inContext:self.context.parentContext];
}

@end
