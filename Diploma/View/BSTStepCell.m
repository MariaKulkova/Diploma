//
//  BSTStepCell.m
//  Diploma
//
//  Created by Maria on 15.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTStepCell.h"

@interface BSTStepCell () <UIGestureRecognizerDelegate>

/** Outlets **/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewLeftConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewRightConstant;
@property (weak, nonatomic) IBOutlet UIView             *swipableContentView;
@property (weak, nonatomic) IBOutlet UIButton           *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton           *completeButton;
@property (weak, nonatomic) IBOutlet UILabel            *stepTitle;
@property (weak, nonatomic) IBOutlet UILabel            *deadlineLabel;
@property (weak, nonatomic) IBOutlet UIView             *completeLine;

/** Custom properties **/
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, assign) CGPoint panStartPoint;
@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;
@property (nonatomic, assign) BOOL    completeShown;
@property (nonatomic, assign) BOOL    deleteShown;

@end

@implementation BSTStepCell

#pragma mark - Init

- (void)awakeFromNib {
    // Initialization code
	self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCellRecognized:)];
	self.panRecognizer.delegate = self;
	[self.swipableContentView addGestureRecognizer:self.panRecognizer];
}

- (void)prepareForReuse {
	[super prepareForReuse];
	[self setConstraintsToOffset:0 animated:NO];
}

#pragma mark = CustomProperties

- (void)setCompleted:(BOOL)completed {
	if (completed) {
		self.completeLine.hidden = NO;
	}
	else {
		self.completeLine.hidden = YES;
	}
}

#pragma mark Content

- (void)setDbEntity:(BSTStep *)step {
	_dbEntity = step;
	self.stepTitle.text = step.title;
	self.completed = step.achieved;
}

#pragma mark - GestureRecognizerDelegate

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
	CGPoint translation = [gestureRecognizer translationInView:[self superview]];
	// Check for horizontal gesture
	if (fabsf(translation.x) > fabsf(translation.y)) {
		return YES;
	}
	return NO;
}

#pragma mark - Constraints

- (void)setConstraintsToOffset:(CGFloat)offset animated:(BOOL)animated {
	if (self.startingRightLayoutConstraintConstant == offset &&
		self.contentViewRightConstant.constant == offset) {
		//Already all the way closed, no bounce necessary
		return;
	}
	
	self.contentViewRightConstant.constant =  offset;
	self.contentViewLeftConstant.constant  = -offset;
	
	[self updateConstraintsIfNeeded:animated completion:nil];
}

- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void (^)(BOOL finished))completion {
	float duration = 0;
	if (animated) {
		duration = 0.2;
	}
	
	[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		[self layoutIfNeeded];
	} completion:completion];
}

#pragma mark - RecognizerAction

- (void)panCellRecognized:(UIPanGestureRecognizer *)recognizer {
	switch (recognizer.state) {
		case UIGestureRecognizerStateBegan:
			self.panStartPoint = [recognizer translationInView:self.swipableContentView];
			self.startingRightLayoutConstraintConstant = self.contentViewRightConstant.constant;
			break;
			
		case UIGestureRecognizerStateChanged: {
			CGPoint currentPoint = [recognizer translationInView:self.swipableContentView];
			CGFloat deltaX = currentPoint.x - self.panStartPoint.x;
			BOOL panningLeft = NO;
			// Detect pan direction
			if (currentPoint.x < self.panStartPoint.x) {
				panningLeft = YES;
			}
			// Calculate pan offset
			CGFloat offset = self.startingRightLayoutConstraintConstant - deltaX;
			
			// Determine maximum right and left offsets
			CGFloat maxLeftOffset, maxRightOffset;
			if (self.deleteShown) {
				maxLeftOffset = CGRectGetWidth(self.deleteButton.frame);
				maxRightOffset = 0;
			}
			else if (self.completeShown) {
				maxLeftOffset = 0;
				maxRightOffset = -CGRectGetWidth(self.completeButton.frame);
			}
			else {
				maxLeftOffset = CGRectGetWidth(self.deleteButton.frame);
				maxRightOffset = -CGRectGetWidth(self.completeButton.frame);
			}
			
			// Change constraint values
			if (!panningLeft) {
				CGFloat constant = MAX(offset, maxRightOffset);
				if (constant == maxRightOffset) {
					[self setConstraintsToOffset:constant animated:YES];
				} else {
					self.contentViewRightConstant.constant = constant;
				}
			} else {
				CGFloat constant = MIN(offset, maxLeftOffset);
				if (constant == maxLeftOffset) {
					[self setConstraintsToOffset:constant animated:YES];
				} else {
					self.contentViewRightConstant.constant = constant;
				}
			}
			
			self.contentViewLeftConstant.constant = -self.contentViewRightConstant.constant;
			break;
		}
			
		case UIGestureRecognizerStateEnded: {
			CGFloat buttonVisible;
			if (self.startingRightLayoutConstraintConstant == 0) {
				buttonVisible = CGRectGetWidth(self.deleteButton.frame) / 4;
			}
			else {
				buttonVisible = CGRectGetWidth(self.deleteButton.frame) * 3 / 4;
			}
			
			if (self.contentViewRightConstant.constant >= buttonVisible) { //3
				//Open all the way
				[self setConstraintsToOffset:CGRectGetWidth(self.deleteButton.frame) animated:YES];
				self.deleteShown = YES;
				self.completeShown = NO;
			} else if (-self.contentViewRightConstant.constant >= buttonVisible) {
				[self setConstraintsToOffset:-CGRectGetWidth(self.completeButton.frame) animated:YES];
				self.deleteShown = NO;
				self.completeShown = YES;
			}
			else {
				//Re-close
				[self setConstraintsToOffset:0 animated:YES];
				self.deleteShown = NO;
				self.completeShown = NO;
			}
			break;
		}
		case UIGestureRecognizerStateCancelled:
			break;
		default:
			break;
	}
}

#pragma mark - IBActions

- (IBAction)deleteButtonTouch:(id)sender {
	[self.delegate deleteActionForSwipeableCell:self];
	[self setConstraintsToOffset:0 animated:YES];
}

- (IBAction)completeButtonTouch:(id)sender {
	[self.delegate completeActionForSwipeableCell:self];
	[self setConstraintsToOffset:0 animated:YES];
}

@end
