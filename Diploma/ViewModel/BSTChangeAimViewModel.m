//
//  BSTChangeAimViewModel.m
//  Diploma
//
//  Created by Maria on 19.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTChangeAimViewModel.h"
#import "Macroses.h"
#import "BSTAim.h"

@interface BSTChangeAimViewModel ()

@property (nonatomic, strong) NSArray *categories;

@end

@implementation BSTChangeAimViewModel

- (void)initialize {
	self.context = [NSManagedObjectContext MR_defaultContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	self.categories = [BSTCategory MR_findAllSortedBy:Key(BSTCategory, title) ascending:YES inContext:self.context];
	if (self.categories.count != 0) {
		self.selectedCategory = self.categories[0];
	}
	
	@weakify(self);
	
	RACCommand *command;
	RACSignal *enabled;
	
	enabled = [RACObserve(self, aimTitle) map:^id(NSString *value) {
		return (value.length == 0) ? @NO : @YES;
	}];
	
	self.executeAimChanging =
	command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self changeAim];
	}];
	
	[command.errors subscribeNext:^(NSError *error) {
		@strongify(self);
		NSLog(@"changeAim: %@", error);
		[self rollbackChanges];
	}];
}

- (RACSignal *)changeAim {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		BSTAim *currentAim;
		if (self.objectId) {
			currentAim = [BSTAim MR_findFirstByAttribute:Key(BSTAim, id) withValue:self.objectId inContext:self.context];
		}
		else {
			currentAim = [BSTAim MR_createInContext:self.context];
			NSUUID *uid = [NSUUID UUID];
			currentAim.id = uid.UUIDString;
		}
		currentAim.title = self.aimTitle;
		currentAim.category = self.selectedCategory;
		BSTCategory *currentCategory = [BSTCategory MR_findFirstByAttribute:@"id" withValue:self.selectedCategory.id inContext:self.context];
		[currentCategory addAimsObject:currentAim];
		
		[subscriber sendCompleted];
		return [RACDisposable disposableWithBlock:^{
		}];
	}]
	doError:^(NSError *error) {
		NSLog(@"%@",error);
	}];
}


@end
