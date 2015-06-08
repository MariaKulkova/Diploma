//
//  BSTCategoryCell.m
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTCategoryCell.h"

@interface BSTCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *categoryTextField;

@end

@implementation BSTCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark Content

- (void)setDbEntity:(BSTCategory *)category {
	_dbEntity = category;
	self.categoryTextField.text = category.title;
}

@end
