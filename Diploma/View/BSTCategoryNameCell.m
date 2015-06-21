//
//  BSTCategoryNameCell.m
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTCategoryNameCell.h"
#import "Constants.h"

@implementation BSTCategoryNameCell

- (void)setDbEntity:(BSTCategory *)category {
	_dbEntity = category;
	self.label.text = category.title;
}

- (void)setActive:(BOOL)flag {
	_active = flag;
	
	self.label.textColor = (flag) ? [UIColor blackColor] : NeutralColor;
	CGFloat   fontSize       = (flag) ? self.class.fontSize  : (self.class.fontSize - 2.);
	self.label.font      = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}

#pragma mark Sizing

+ (CGFloat)widthForDBEntity:(BSTCategory *)category {
	NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:(self.fontSize + 1.)]};
	return MAX([category.title sizeWithAttributes:attributes].width, 50.);
}

+ (CGFloat)fontSize {
	return 15.;
}


@end
