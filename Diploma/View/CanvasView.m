//
//  CanvasView.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "CanvasView.h"
#import "BSTSpline.h"

@interface CanvasView ()

@end

@implementation CanvasView

- (void)awakeFromNib {
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	
	CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
	CGContextFillRect(context, rect);
	
	self.commonAimsCount = 20;
	self.achievedAimsCount = 10;

	NSArray *interpolatedPoints = [self computePathPoints:rect];
	NSArray *stations = [self computePathStations:interpolatedPoints];
	NSInteger currentStepIndex = [interpolatedPoints indexOfObjectIdenticalTo:stations[self.achievedAimsCount + 1]];
	NSRange range;
	
	range.location = 0;
	range.length   = currentStepIndex;
	NSArray *completedPath = [interpolatedPoints subarrayWithRange:range];
	
	range.location = currentStepIndex;
	range.length   = interpolatedPoints.count - currentStepIndex;
	NSArray *futurePath = [interpolatedPoints subarrayWithRange:range];
	
	[self drawPath:completedPath withColor:[UIColor colorWithRed:150.0/255.0 green:70.0/255.0 blue:255.0/255.0 alpha:1.0] withThickness:2.0 inRect:rect];
	
	CGFloat dashes[] = {10,10};
	CGContextSetLineDash(context, 0.0, dashes, 2);
	CGContextSetLineWidth(context, 1.0);
	[self drawPath:futurePath withColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] withThickness:2.0 inRect:rect];

	for (NSInteger i = 0; i <= self.achievedAimsCount + 1; i++) {
		CGPoint point = [[stations objectAtIndex:i] CGPointValue];
		CGContextSetFillColorWithColor(context,[UIColor colorWithRed:150.0/255.0 green:70.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor);
		CGRect rectangle = CGRectMake(point.y - 3, rect.size.height - point.x - 3, 6, 6);
		CGContextAddEllipseInRect(context, rectangle);
		CGContextFillPath(context);
	}
	
	for (NSInteger i = self.achievedAimsCount + 2; i < stations.count; i++) {
		CGPoint point = [[stations objectAtIndex:i] CGPointValue];
		CGContextSetFillColorWithColor(context,[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1].CGColor);
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
	for (CGFloat y = 0; y <= rect.size.height ; y += rect.size.height / 10) {
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
	CGFloat offset = floor(pathPoints.count / (self.commonAimsCount + 1));
	NSMutableArray *stations = [[NSMutableArray alloc] init];
	
	for (int i = 1; i < pathPoints.count; i += offset) {
		[stations addObject:pathPoints[i]];
	}
	
	return stations;
}

@end
