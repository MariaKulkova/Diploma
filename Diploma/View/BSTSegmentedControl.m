//
//  BSTSegmentedControl.m
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTSegmentedControl.h"
#import "Macroses.h"

@implementation BSTSegmentedControl

- (void)awakeFromNib {
	[super awakeFromNib];
	// custom appearance if needed
	
	self.layer.borderColor = [UIColorFromHEX(0x1B8173) CGColor];
	self.layer.borderWidth = .5;
	
	self.tintColor = UIColorFromHEX(0x1B8173);
	
	// Customize text labels
	
	NSDictionary *attributes;
	
	attributes = @{NSForegroundColorAttributeName: UIColorFromHEX(0x1B8173)};
	[self setTitleTextAttributes:attributes forState:UIControlStateNormal];
	
	attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
	[self setTitleTextAttributes:attributes forState:UIControlStateSelected];
}

@end
