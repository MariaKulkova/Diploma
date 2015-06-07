//
//  BSTManagedObject.h
//  Diploma
//
//  Created by Maria on 04.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface BSTManagedObject : NSManagedObject

- (NSDictionary *)representInfo;

@end

@interface BSTManagedObject (Fill)

- (void)fillWithUserInfo:(NSDictionary *)info;

@end
