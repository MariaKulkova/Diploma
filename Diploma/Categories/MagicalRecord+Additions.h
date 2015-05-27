//
//  MagicalRecord+Additions.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface MagicalRecord (Additions)

+ (void)truncateAllEntitiesInContext:(NSManagedObjectContext *)context;

+ (void)saveInContext:(NSManagedObjectContext *)context withBlock:(void (^)(NSManagedObjectContext *context))block;
+ (void)saveInContext:(NSManagedObjectContext *)context withBlock:(void (^)(NSManagedObjectContext *context))block completion:(MRSaveCompletionHandler)completion;
+ (void)saveInContextAndWait:(NSManagedObjectContext *)context withBlock:(void (^)(NSManagedObjectContext *context))block;

@end
