//
//  BSTAimCell.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAimCell.h"

@implementation BSTAimCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark Content

- (void)setDbEntity:(BSTAim *)aim {
	_dbEntity = aim;
	self.textLabel.text = aim.title;
}

@end
