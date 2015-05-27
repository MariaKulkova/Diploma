//
//  CanvasView.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "CanvasView.h"
#import "BSTSpline.h"

@implementation CanvasView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	

	CGFloat k = (rect.size.height / rect.size.width);
	CGFloat m = 0;
	
	CGContextSetRGBStrokeColor(context, 200, 200, 200, 1);
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
	

	for (NSInteger i = 0; i < interpolatedPoints.count; i++) {
		CGPoint point = [[interpolatedPoints objectAtIndex:i] CGPointValue];
		if (i == 0) {
			CGContextMoveToPoint(context, point.y, rect.size.height - point.x);
		}
		else {
			CGContextAddLineToPoint(context, point.y, rect.size.height - point.x);
		}
	}
	CGContextStrokePath(context);
	
	for (NSInteger i = 0; i < 30; i++) {
		CGPoint point = [[points objectAtIndex:i] CGPointValue];
		CGContextSetFillColorWithColor(context,
										 [UIColor blueColor].CGColor);
		CGRect rectangle = CGRectMake(point.y - 2, rect.size.height - point.x - 2, 4, 4);
		CGContextAddEllipseInRect(context, rectangle);
		CGContextFillPath(context);
	}
}

@end
