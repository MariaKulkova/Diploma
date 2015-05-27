//
//  BSTUser.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BSTCategory, BSTRewarding;

@interface BSTUser : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet    *categories;
@property (nonatomic, retain) NSSet    *achievements;
@end

@interface BSTUser (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(BSTCategory *)value;
- (void)removeCategoriesObject:(BSTCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

- (void)addAchievementsObject:(BSTRewarding *)value;
- (void)removeAchievementsObject:(BSTRewarding *)value;
- (void)addAchievements:(NSSet *)values;
- (void)removeAchievements:(NSSet *)values;

@end

@interface BSTUser (Custom)

+ (instancetype)currentUser;
+ (instancetype)currentUserInContext:(NSManagedObjectContext *)context;

@end

