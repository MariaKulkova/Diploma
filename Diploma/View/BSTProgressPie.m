//
//  BSTPieChat.m
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTProgressPie.h"

@interface BSTProgressPie ()

@property (nonatomic, assign) CGFloat circleRadius;
@property (nonatomic, retain) NSArray *sliceArray;
@property (nonatomic, retain) NSArray *colorsArray;

@end

@implementation BSTProgressPie

- (void) awakeFromNib {
	[super awakeFromNib];
	// Set up the colors for the slices
	self.colorsArray = [NSArray arrayWithObjects:(id)[UIColor orangeColor].CGColor,
					   (id)[UIColor greenColor].CGColor, nil];
	self.percentage = 36;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self drawPieChart:context];
}

- (void)drawPieChart:(CGContextRef)context  {
	CGPoint circleCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
	
	// Set the radius of your pie chart
	self.circleRadius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;
	
	// Determin progress area
	CGFloat passedAngle = (self.percentage / 100) * 2 * M_PI - M_PI/2;
	
	CGContextSetFillColorWithColor(context, (CGColorRef)[_colorsArray objectAtIndex:0]);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
	CGContextAddArc(context, circleCenter.x, circleCenter.y, self.circleRadius, - M_PI/2, passedAngle, 0);
	CGContextClosePath(context);
	CGContextFillPath(context);
	
	CGContextSetFillColorWithColor(context, (CGColorRef)[_colorsArray objectAtIndex:1]);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, circleCenter.x, circleCenter.y);
	CGContextAddArc(context, circleCenter.x, circleCenter.y, self.circleRadius, passedAngle, M_PI*2 - M_PI/2, 0);
	CGContextClosePath(context);
	CGContextFillPath(context);
}

@end
