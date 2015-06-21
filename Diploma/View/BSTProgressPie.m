//
//  BSTPieChat.m
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTProgressPie.h"
#import "Macroses.h"
#import "Constants.h"

@interface BSTProgressPie ()

@property (nonatomic, assign) CGFloat circleRadius;
@property (nonatomic, retain) NSArray *sliceArray;
@property (nonatomic, retain) NSArray *colorsArray;

@end

@implementation BSTProgressPie

- (void) awakeFromNib {
	[super awakeFromNib];
	// Set up the colors for the slices
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawPieChart:context];
}

- (void)drawPieChart:(CGContextRef)context {
	CGPoint circleCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
	
	// Set the radius of your pie chart
	self.circleRadius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;
	
	// Determin progress area
	CGFloat passedAngle = (self.percentage / 100) * 2 * M_PI - M_PI/2;
	CGFloat startAngel;
	if (self.percentage == 0) {
		startAngel = passedAngle;
	}
	else {
		startAngel = - M_PI / 2;
	}
	
	CGContextSetFillColorWithColor(context, BaseCompleteColor.CGColor);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
	CGContextAddArc(context, circleCenter.x, circleCenter.y, self.circleRadius, startAngel, passedAngle, 0);
	CGContextClosePath(context);
	CGContextFillPath(context);
	
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
	CGContextAddArc(context, circleCenter.x, circleCenter.y, self.circleRadius, passedAngle, M_PI*2 - M_PI/2, 0);
	CGContextClosePath(context);
	CGContextFillPath(context);
	
	CGContextSetStrokeColorWithColor(context, NeutralColor.CGColor);
	CGContextSetLineWidth(context, 1.0);
	CGContextAddEllipseInRect(context, CGRectMake(self.bounds.origin.x + 1, self.bounds.origin.y+1, self.bounds.size.width - 2, self.bounds.size.height-2));
	CGContextStrokePath(context);
}

@end
