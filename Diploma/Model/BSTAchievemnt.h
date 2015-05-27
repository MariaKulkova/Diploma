//
//  BSTAchievemnt.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BSTRewarding;

@interface BSTAchievemnt : NSManagedObject

@property (nonatomic)         int64_t  id;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *imageURL;

@property (nonatomic, retain) NSSet    *rewardings;
@end

@interface BSTAchievemnt (CoreDataGeneratedAccessors)

- (void)addRewardingsObject:(BSTRewarding *)value;
- (void)removeRewardingsObject:(BSTRewarding *)value;
- (void)addRewardings:(NSSet *)values;
- (void)removeRewardings:(NSSet *)values;

@end
