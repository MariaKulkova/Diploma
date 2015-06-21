//
//  BSTChangeCategoryViewModel.m
//  Diploma
//
//  Created by Maria on 20.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTChangeCategoryViewModel.h"
#import "BSTCategory.h"
#import "Macroses.h"

@implementation BSTChangeCategoryViewModel

- (void)initialize {
	self.context = [NSManagedObjectContext MR_defaultContext];
//	self.context = [[NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_defaultContext]] listenChangesFromParentContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	
	@weakify(self);
	
	RACCommand *command;
	RACSignal *enabled;
	
	enabled = [RACObserve(self, categoryTitle) map:^id(NSString *value) {
		return (value.length == 0) ? @NO : @YES;
	}];
	
	self.executeCategoryChanging =
	command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self changeCategory];
	}];
	
	[command.errors subscribeNext:^(NSError *error) {
		@strongify(self);
		NSLog(@"changeAim: %@", error);
		[self rollbackChanges];
	}];
}

- (void)saveChanges {
	NSLog(@"Save to persistent storage");
	[self.context MR_saveToPersistentStoreAndWait];
}

- (void)rollbackChanges {
	[self.context rollback];
}

- (RACSignal *)changeCategory {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		BSTCategory *currentCategory;
		if (self.objectId) {
			currentCategory = [BSTCategory MR_findFirstByAttribute:Key(BSTCategory, id) withValue:self.objectId inContext:self.context];
		}
		else {
			currentCategory = [BSTCategory MR_createInContext:self.context];
			NSUUID *uid = [NSUUID UUID];
			currentCategory.id = uid.UUIDString;
		}
		currentCategory.title = self.categoryTitle;
		
		[subscriber sendCompleted];
		return [RACDisposable disposableWithBlock:^{
		}];
	}]
	doError:^(NSError *error) {
		NSLog(@"%@",error);
	}];
}

@end
