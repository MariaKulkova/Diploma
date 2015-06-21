//
//  BSTParseAPIClient.h

//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BSTManagedObject.h"

@interface BSTParseAPIClient : NSObject

+ (RACSignal *)addObject:(BSTManagedObject *) object;

@end
