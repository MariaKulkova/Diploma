//
//  BSTCategoryNameCell.h
//  Diploma
//
//  Created by Maria on 27.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTCategory.h"

@interface BSTCategoryNameCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) BSTCategory *dbEntity;
@property (nonatomic, assign) BOOL active;

+ (CGFloat)widthForDBEntity:(BSTCategory *)dbEntity;

@end
