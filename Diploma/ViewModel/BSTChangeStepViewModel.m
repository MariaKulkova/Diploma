//
//  BSTChangeStepViewModel.m
//  Diploma
//
//  Created by Maria on 21.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTChangeStepViewModel.h"
#import "BSTStep.h"
#import "Macroses.h"

@implementation BSTChangeStepViewModel

- (void)initialize {
	//	self.context = [[NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_defaultContext]] listenChangesFromParentContext];
	self.context = [NSManagedObjectContext MR_defaultContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	
	@weakify(self);
	
	RACCommand *command;
	RACSignal *enabled;
	
	enabled = [RACObserve(self, stepTitle) map:^id(NSString *value) {
		return (value.length == 0) ? @NO : @YES;
	}];
	
	self.executeStepChanging =
	command = [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self changeStep];
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

- (RACSignal *)changeStep {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		BSTStep *currentStep;
		if (self.objectId) {
			currentStep = [BSTStep MR_findFirstByAttribute:Key(BSTStep, id) withValue:self.objectId inContext:self.context];
		}
		else {
			currentStep = [BSTStep MR_createInContext:self.context];
			NSUUID *uid = [NSUUID UUID];
			currentStep.id = uid.UUIDString;
			currentStep.aim = self.selectedAim;
			BSTAim *currentAim = [BSTAim MR_findFirstByAttribute:@"id" withValue:self.selectedAim.id inContext:self.context];
			[currentAim addStepsObject:currentStep];
		}
		currentStep.title = self.stepTitle;
		currentStep.achieved = NO;
		
		[subscriber sendCompleted];
		return [RACDisposable disposableWithBlock:^{
		}];
	}]
	doError:^(NSError *error) {
		NSLog(@"%@",error);
	}];
}


@end
