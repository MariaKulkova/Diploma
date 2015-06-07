//
//  BSTSyncEngine.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTSyncEngine.h"
#import <CoreData/CoreData.h>

@interface BSTSyncEngine ()

@end

@implementation BSTSyncEngine

#pragma mark - Init

+ (instancetype)sharedInstance {
	static id instance = nil;
	static dispatch_once_t once_token = 0;
	
	dispatch_once(&once_token, ^{
		instance = [[self class] new];
	});
	
	return instance;
}

- (instancetype)init {
	if (self = [super init]) {
		[self initialize];
	}
	return self;
}

- (void)initialize {
	@weakify(self);
	RACCommand *command;
	
	//RACSignal *authInvalidated = [[FWAPI isAuthorized] ignore:@YES];
	
//	_fetchSubscriptions =
//	command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//		return [[[[FWAPI subscriptions]
//				  fw_retry:0]
//				 doNext:^(RACTuple *tuple) {
//					 @strongify(self);
//					 [self parseFetchResult:tuple];
//				 }]
//				takeUntil:authInvalidated];
//	}];
//	[command.errors subscribeNext:^(NSError *error) {
//		DLog(@"subscriptions: %@", error);
//	}];
//	[[command.executionSignals switchToLatest] subscribeNext:^(id _) {
//		DLog(@"subscriptions done!");
//	}];
	
//	_syncSubscriptions =
//	command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id _) {
//		@strongify(self);
//		NSManagedObjectContext *context = [NSManagedObjectContext MR_context];
//		RACSignal *subscribe = [[FWAPI
//								 applySubscriptions:[[self class] unregisteredSubscriptionsInContext:context]]
//								fw_retry:0];
//		RACSignal *unsubscribe = [[FWAPI
//								   removeSubscriptions:[[self class] deprecatedSubscriptionsInContext:context]]
//								  fw_retry:0];
//		return [[RACSignal
//				 concat:@[subscribe, unsubscribe]]
//				takeUntil:authInvalidated];
//	}];
//	[command.errors subscribeNext:^(id x) {
//		DLog(@"sync subscriptions: %@", x);
//	}];
//	[[command.executionSignals switchToLatest] subscribeNext:^(id _) {
//		DLog(@"sync subscriptions done!");
//	}];
	
	// Working loop
	[self.syncData execute:nil];
}

//- (void)addObject:

//- (void)subscribeGenres:(NSSet *)genres artists:(NSSet *)artists {
//	[MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *context) {
//		[self subscribeFans:[self remap:genres inContext:context] withSubscriptionClass:FWGenreSubscription.class inContext:context];
//		[self subscribeFans:[self remap:artists inContext:context] withSubscriptionClass:FWArtistSubscription.class inContext:context];
//	}];
//}

@end
