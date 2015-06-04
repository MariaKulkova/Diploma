//
//  BSTSpline.m
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTSpline.h"

@implementation BSTSpline

+ (NSArray *)calculateDerivatives: (NSArray *) functionPoints withFirstDerivative: (CGFloat) firstDerivative withLastDerivative: (CGFloat) lastDerivative {
	NSMutableArray *functionDerivatives = [NSMutableArray arrayWithCapacity:functionPoints.count];
	[functionDerivatives addObject:[NSNumber numberWithFloat:firstDerivative]];
	
	for (int i = 1; i < functionPoints.count - 1; i++) {
		CGPoint previousPoint = [functionPoints[i-1] CGPointValue];
		CGPoint currentPoint  = [functionPoints[i] CGPointValue];
		CGPoint nextPoint     = [functionPoints[i+1] CGPointValue];
		
		CGFloat derivativeValue;
		if (((previousPoint.x > currentPoint.x) && (nextPoint.x > currentPoint.x)) ||
			((previousPoint.x < currentPoint.x) && (nextPoint.x < currentPoint.x))) {
			derivativeValue = 0.5 * ((currentPoint.y - previousPoint.y) / (currentPoint.x - previousPoint.x) +
											 (nextPoint.y - currentPoint.y) / (nextPoint.x - currentPoint.x));
		}
		else {
			derivativeValue = 0;
		}

		[functionDerivatives addObject:[NSNumber numberWithFloat:derivativeValue]];
	}
	[functionDerivatives addObject:[NSNumber numberWithFloat:lastDerivative]];
	
	return [NSArray arrayWithArray:functionDerivatives];
}

+ (NSArray *) interpolateFunction: (NSArray *) functionPoints
						 withStep: (CGFloat) step
			  withfirstDerivative: (CGFloat) firstDerivative
			   withLastDerivative: (CGFloat) lastDerivative {
	NSArray *derivatives = [BSTSpline calculateDerivatives:functionPoints withFirstDerivative:firstDerivative withLastDerivative:lastDerivative];
	NSMutableArray *graphPoints = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < functionPoints.count - 1; i++) {
		CGPoint firstPoint       = [functionPoints[i] CGPointValue];
		CGPoint secondPoint      = [functionPoints[i + 1] CGPointValue];
		CGFloat firstDerivative  = [derivatives[i] floatValue];
		CGFloat secondDerivative = [derivatives[i + 1] floatValue];
		
		CGFloat delta = secondPoint.x - firstPoint.x;
		CGFloat l = secondPoint.y - firstPoint.y - 0.5 * delta * (secondDerivative + firstDerivative);
		
		CGFloat constP = (-l - copysign(1.0, l) * sqrt(l * l + 0.25 * delta * delta * (secondDerivative - firstDerivative) * (secondDerivative - firstDerivative)))
		                 / (0.5 * delta * delta);
		CGFloat constD;
		if (constP == 0) {
			constD = 0;
		}
		else {
			constD = (firstDerivative - secondDerivative + delta * constP) / (2 * constP);
		}
		
		for (CGFloat x = 0; x < delta; x += step) {
			CGFloat yValue = 0;
			if (x <= constD) {
				yValue = firstPoint.y + firstDerivative * x - x * x * constP / 2;
			}
			else {
				yValue = secondPoint.y - secondDerivative * (delta - x) + (delta - x) * (delta - x) * constP / 2;
			}
			[graphPoints addObject:[NSValue valueWithCGPoint:CGPointMake(firstPoint.x + x, yValue)]];
		}
	}
	[graphPoints addObject:functionPoints.lastObject];
	return [NSArray arrayWithArray:graphPoints];
}

@end
