//
//  BSTStepCell.h
//  Diploma
//
//  Created by Maria on 15.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTStep.h"

@class BSTStepCell;

@protocol SwipeableCellDelegate <NSObject>
- (void)deleteActionForSwipeableCell:(BSTStepCell *)swipeableCell;
- (void)completeActionForSwipeableCell:(BSTStepCell *)swipeableCell;
@end

@interface BSTStepCell : UITableViewCell

/** Delegate **/
@property (nonatomic, weak) id <SwipeableCellDelegate> delegate;

@property (nonatomic, strong) BSTStep *dbEntity;
@property (nonatomic, assign) BOOL    completed;

@end

