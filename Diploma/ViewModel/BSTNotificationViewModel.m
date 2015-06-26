//
//  BSTNotificationViewModel.m
//  Diploma
//
//  Created by Maria on 22.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTNotificationViewModel.h"
#import "Macroses.h"

@implementation BSTNotificationViewModel

- (void)initialize {
	self.context = [NSManagedObjectContext MR_defaultContext];
	self.context.MR_workingName = NSStringFromClass([self class]);
	
	@weakify(self);
	
	RACCommand *command;
	
	self.executeNotificationChanging =
	command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		@strongify(self);
		return [self changeNotification];
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
	if (self.activated) {
		UILocalNotification* localNotification = [[UILocalNotification alloc] init];
		localNotification.fireDate = self.date;
		localNotification.alertBody = [NSString stringWithFormat:@"You need to %@", self.selectedStep.title];
		localNotification.timeZone = [NSTimeZone defaultTimeZone];
		localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
		
		[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
	}
}

- (RACSignal *)changeNotification {
	return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		BSTReminder *currentReminder;
		if (self.objectId) {
			currentReminder = [BSTReminder MR_findFirstByAttribute:Key(BSTReminder, id) withValue:self.objectId inContext:self.context];
		}
		else {
			currentReminder = [BSTReminder MR_createInContext:self.context];
			NSUUID *uid = [NSUUID UUID];
			currentReminder.id = uid.UUIDString;
			currentReminder.step = self.selectedStep;
			BSTStep *currentStep = [BSTStep MR_findFirstByAttribute:@"id" withValue:self.selectedStep.id inContext:self.context];
			currentStep.reminder = currentReminder;
		}
		currentReminder.activated = self.activated;
		currentReminder.period = self.period;
		currentReminder.date = self.date;
		
		[subscriber sendCompleted];
		return [RACDisposable disposableWithBlock:^{
		}];
	}]
	doError:^(NSError *error) {
		NSLog(@"%@",error);
	}];
}

@end
