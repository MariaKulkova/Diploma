//
//  BSTAimCell.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAimCell.h"
#import "BSTProgressPie.h"

@interface BSTAimCell ()

@property (weak, nonatomic) IBOutlet UILabel *aimTextField;
@property (weak, nonatomic) IBOutlet BSTProgressPie *progressImage;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (nonatomic) CGFloat positionStart;

@end

@implementation BSTAimCell

- (void)awakeFromNib {
}

#pragma mark Content

- (void)setDbEntity:(BSTAim *)aim {
	_dbEntity = aim;
	self.aimTextField.text = aim.title;
}

@end
