//
//  MagicalRecord+Additions.m
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "MagicalRecord+Additions.h"

@implementation MagicalRecord (Additions)

+ (void)truncateAllEntitiesInContext:(NSManagedObjectContext *)context {
	[[NSManagedObjectModel MR_defaultManagedObjectModel].entities enumerateObjectsUsingBlock:^(NSEntityDescription *entityDescription, NSUInteger idx, BOOL *stop) {
		[NSClassFromString([entityDescription managedObjectClassName]) MR_truncateAllInContext:context];
	}];
}


+ (void)saveInContext:(NSManagedObjectContext *)context withBlock:(void (^)(NSManagedObjectContext *))block {
	[self saveInContext:context withBlock:block completion:nil];
}

+ (void)saveInContext:(NSManagedObjectContext *)context withBlock:(void (^)(NSManagedObjectContext *))block completion:(MRSaveCompletionHandler)completion {
	[context performBlock:^{
		if (block) {
			block(context);
		}
		[context MR_saveWithOptions:MRSaveParentContexts completion:completion];
	}];
}

+ (void)saveInContextAndWait:(NSManagedObjectContext *)context withBlock:(void (^)(NSManagedObjectContext *))block {
	[context performBlockAndWait:^{
		if (block) {
			block(context);
		}
		[context MR_saveWithOptions:MRSaveParentContexts|MRSaveSynchronously completion:nil];
	}];
}

@end
