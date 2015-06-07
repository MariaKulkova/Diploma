//
//  BSTParseAPIClient.h

//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLSession+RACSupport.h"
#import "BSTManagedObject.h"

@interface BSTParseAPIClient : NSObject

- (RACSignal *)addObject:(BSTManagedObject *) object;

@end
