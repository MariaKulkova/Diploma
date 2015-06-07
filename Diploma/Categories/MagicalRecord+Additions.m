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

@implementation NSManagedObjectContext (MergingContexts)

//+ (void)load {
//	static dispatch_once_t onceToken;
//	dispatch_once(&onceToken, ^{
//		Class class = [self class];
//		
//		SEL originalSelector = NSSelectorFromString(@"dealloc");
//		SEL swizzledSelector = @selector(swizzledDealloc);
//		
//		Method originalMethod = class_getInstanceMethod(class, originalSelector);
//		Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//		
//		// When swizzling a class method, use the following:
//		// Class class = object_getClass((id)self);
//		// ...
//		// Method originalMethod = class_getClassMethod(class, originalSelector);
//		// Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
//		
//		BOOL didAddMethod =
//		class_addMethod(class, originalSelector,
//						method_getImplementation(swizzledMethod),
//						method_getTypeEncoding(swizzledMethod));
//		
//		if (didAddMethod) {
//			class_replaceMethod(class, swizzledSelector,
//								method_getImplementation(originalMethod),
//								method_getTypeEncoding(originalMethod));
//		} else {
//			method_exchangeImplementations(originalMethod, swizzledMethod);
//		}
//	});
//}
//
//- (void)swizzledDealloc {
//	[NSNotificationCenter.defaultCenter removeObserver:self];
//	
//	// Call [super dealloc]
//	// It won't lead to infinite loop due to method swizzling.
//	// RTFM http://nshipster.com/method-swizzling/ @ "Invoking _cmd" part
//	[self swizzledDealloc];
//}

- (instancetype)listenChangesFromParentContext {
	if (self.parentContext) {
		[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(mergeChangesFromContextDidSaveNotification:) name:NSManagedObjectContextDidSaveNotification object:self.parentContext];
	}
	
	return self;
}

@end

@implementation NSManagedObject (Additions)

+ (id)fw_findFirstOrCreateByAttribute:(NSString *)attribute withValue:(id)searchValue inContext:(NSManagedObjectContext *)context {
	return [self MR_findFirstByAttribute:attribute withValue:searchValue inContext:context] ?: [self MR_createInContext:context];
}

@end

