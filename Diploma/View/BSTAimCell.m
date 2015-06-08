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
    // Initialization code
	
	UIPanGestureRecognizer *tapRecognizer = [[UIPanGestureRecognizer alloc]
											 initWithTarget:self action:@selector(respondToPanGesture:)];
 
	// Specify that the gesture must be a single tap
	tapRecognizer.minimumNumberOfTouches = 1;
 
	// Add the tap gesture recognizer to the view
	[self.contentView addGestureRecognizer:tapRecognizer];
}

- (IBAction)respondToPanGesture:(UIPanGestureRecognizer *)recognizer {
	CGFloat y = [recognizer locationInView:self.contentView].x;
	
	if(recognizer.state == UIGestureRecognizerStateBegan){
		//Snag the Y position of the touch when panning begins
		_positionStart = [recognizer locationInView:self.contentView].x;
	}
	else if(recognizer.state == UIGestureRecognizerStateChanged){
		//This represents the true offset with the touch position accounted for
		CGFloat trueOffset = y - _positionStart;
		
		if (trueOffset >= 0) {
			//Use this offset to adjust the position of your view accordingly
			CGRect frame = self.contentView.frame;
			frame.origin.x += trueOffset;
			[self.contentView setFrame:frame];
		}
	}
}

#pragma mark Content

- (void)setDbEntity:(BSTAim *)aim {
	_dbEntity = aim;
	self.aimTextField.text = aim.title;
}

@end
