//
//  BSTStepViewModel.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTStepViewModel.h"
#import "Macroses.h"
#import "BSTStep.h"

@interface BSTStepViewModel ()

@property (nonatomic, strong) NSArray *steps;

@end

@implementation BSTStepViewModel

#pragma mark Init

- (void)initialize {
	self.context = [NSManagedObjectContext MR_defaultContext];
	//self.context = [[NSManagedObjectContext MR_contextWithParent:[NSManagedObjectContext MR_defaultContext]] listenChangesFromParentContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	self.steps = [self.selectedAim.steps sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:Key(BSTStep, title) ascending:YES]]];
}

#pragma mark Private

- (void)updateData {
	self.steps = [self.selectedAim.steps sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:Key(BSTStep, title) ascending:YES]]];
}

#pragma mark - Public

- (void)saveChanges {
	NSLog(@"Save to persistent storage");
	[self.context MR_saveToPersistentStoreAndWait];
}

- (void)rollbackChanges {
	[self.context rollback];
}

- (void)deleteStep:(BSTStep *)step {
	[step MR_deleteEntity];
	[self saveChanges];
	[self updateData];
}

- (void)completeStep:(BSTStep *)step {
	step.achieved = YES;
	[self saveChanges];
}

@end
