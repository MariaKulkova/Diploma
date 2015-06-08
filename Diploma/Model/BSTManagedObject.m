//
//  BSTManagedObject.m
//  Diploma
//
//  Created by Maria on 04.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTManagedObject.h"

@implementation BSTManagedObject

- (NSDictionary *)representInfo {
	// Must be overrided by child classes
	return nil;
}

@end

@implementation BSTManagedObject (Custom)

+ (void)deprecateEntities:(id<NSFastEnumeration>)entities inContext:(NSManagedObjectContext *)context {
	for (BSTManagedObject *entity in entities) {
		NSLog(@"Deprecate %@", entity);
		[entity MR_deleteInContext:context];
	}
}

- (void)deprecateEntities:(id<NSFastEnumeration>)entities {
	[[self class] deprecateEntities:entities inContext:self.managedObjectContext];
}

@end
