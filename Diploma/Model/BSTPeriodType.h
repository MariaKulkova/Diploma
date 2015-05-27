//
//  BSTPeriodType.h
//  Diploma
//
//  Created by Maria on 24.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BSTPeriodType : NSManagedObject

@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSSet    *periods;

@end
