//
//  CanvasView.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTPathView.h"
#import "BSTSpline.h"
#import "Constants.h"

@interface BSTPathView ()

@end

@implementation BSTPathView

- (void)awakeFromNib {
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	
	CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
	CGContextFillRect(context, rect);

	NSArray *interpolatedPoints = [self computePathPoints:rect];
	NSArray *stations = [self computePathStations:interpolatedPoints];
	NSInteger currentStepIndex;
	
	if (self.achievedAimsCount == 0) {
		currentStepIndex = 0;
	}
	else if (self.achievedAimsCount == self.commonAimsCount) {
		currentStepIndex = interpolatedPoints.count;
	}
	else {
		currentStepIndex = [interpolatedPoints indexOfObjectIdenticalTo:stations[self.achievedAimsCount - 1]];
	}
	NSRange range;
	
	range.location = 0;
	range.length   = currentStepIndex;
	NSArray *completedPath = [interpolatedPoints subarrayWithRange:range];
	
	range.location = currentStepIndex;
	range.length   = interpolatedPoints.count - currentStepIndex;
	NSArray *futurePath = [interpolatedPoints subarrayWithRange:range];
	
	[self drawPath:completedPath withColor:BaseRedColor withThickness:2.0 inRect:rect];
	
	CGFloat dashes[] = {10,10};
	CGContextSetLineDash(context, 0.0, dashes, 2);
	CGContextSetLineWidth(context, 1.0);
	[self drawPath:futurePath withColor:NeutralColor withThickness:2.0 inRect:rect];

	for (NSInteger i = 0; i < self.achievedAimsCount; i++) {
		CGPoint point = [[stations objectAtIndex:i] CGPointValue];
		CGContextSetFillColorWithColor(context, BaseRedColor.CGColor);
		CGRect rectangle = CGRectMake(point.y - 3, rect.size.height - point.x - 3, 6, 6);
		CGContextAddEllipseInRect(context, rectangle);
		CGContextFillPath(context);
	}
	
	for (NSInteger i = self.achievedAimsCount; i < stations.count; i++) {
		CGPoint point = [[stations objectAtIndex:i] CGPointValue];
		CGContextSetFillColorWithColor(context,NeutralColor.CGColor);
		CGRect rectangle = CGRectMake(point.y - 3, rect.size.height - point.x - 3, 6, 6);
		CGContextAddEllipseInRect(context, rectangle);
		CGContextFillPath(context);
	}
}

- (void)drawPath:(NSArray *) points withColor:(UIColor *) color withThickness:(CGFloat) thickness inRect:(CGRect) rect{
	CGContextRef context = UIGraphicsGetCurrentContext();
	const CGFloat *components = CGColorGetComponents(color.CGColor);
	CGContextSetRGBStrokeColor(context, components[0], components[1], components[2], CGColorGetAlpha(color.CGColor));
	CGContextSetLineWidth(context, thickness);
	for (NSInteger i = 0; i < points.count; i++) {
		CGPoint point = [[points objectAtIndex:i] CGPointValue];
		if (i == 0) {
			CGContextMoveToPoint(context, point.y, rect.size.height - point.x);
		}
		else {
			CGContextAddLineToPoint(context, point.y, rect.size.height - point.x);
		}
	}
	CGContextStrokePath(context);
}

- (NSArray *)computePathPoints:(CGRect) rect {
	CGFloat k = (rect.size.height / rect.size.width);
	CGFloat m = 0;
	
	srand48(time(0));
	NSMutableArray *points = [[NSMutableArray alloc] init];
	for (CGFloat y = 0; y <= rect.size.height ; y += rect.size.height / 5) {
		CGFloat x = (y - m) / k;
		if (y != 0 && (y + rect.size.height / 10 < rect.size.height)) {
			x += drand48() * rect.size.width - x;
		}
		[points addObject:[NSValue valueWithCGPoint:CGPointMake(y, x)]];
	}
	NSArray *interpolatedPoints = [BSTSpline interpolateFunction:points withStep:0.1 withfirstDerivative:0 withLastDerivative:0];
	
	return interpolatedPoints;
}

- (NSArray *)computePathStations:(NSArray *) pathPoints  {
	NSMutableArray *stations = [[NSMutableArray alloc] init];
	
	if (self.commonAimsCount != 0) {
		CGFloat offset = floor(pathPoints.count / self.commonAimsCount - 1);
		for (int i = offset; i < pathPoints.count; i += offset) {
			[stations addObject:pathPoints[i]];
		}
	}
	
	return stations;
}

@end
