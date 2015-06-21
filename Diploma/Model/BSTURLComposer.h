//
//  BSTURLComposer.h
//  Diploma
//
//  Created by Maria on 04.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTURLComposer : NSObject

+ (NSURL *)constructURL:(NSString *)path;

+ (NSURL *)serviceURL:(NSString *)parameters, ... NS_REQUIRES_NIL_TERMINATION;

@end
