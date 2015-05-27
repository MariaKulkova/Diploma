//
//  BSTSpline.h
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTSpline : NSObject

+ (NSArray *) interpolateFunction: (NSArray *) functionPoints
						 withStep: (CGFloat) step
			  withfirstDerivative: (CGFloat) firstDerivative
			   withLastDerivative: (CGFloat) lastDerivative;

@end
