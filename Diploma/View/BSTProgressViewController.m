//
//  BSTProgressViewController.m
//  Diploma
//
//  Created by Maria on 20.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTProgressViewController.h"
#import "BSTPathView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface BSTProgressViewController ()
@property (weak, nonatomic) IBOutlet UILabel     *aimTitleLabel;
@property (weak, nonatomic) IBOutlet BSTPathView *pathView;
@property (weak, nonatomic) IBOutlet UIImageView *airBalloonImage;
@end

@implementation BSTProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.aimTitleLabel.text = self.presentedAim.title;
	[self reloadData];
	
	CABasicAnimation *movementAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
	[movementAnimation setFromValue:[NSValue valueWithCGPoint:[[self.airBalloonImage.layer presentationLayer] position]]];
	[movementAnimation setToValue:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
	[movementAnimation setDuration:3.0];
	[movementAnimation setRepeatCount:10];
	
	[self.airBalloonImage.layer addAnimation:movementAnimation forKey:@"ballAnimation"];
}

- (void)reloadData {
	self.pathView.commonAimsCount = self.presentedAim.steps.count;
	self.pathView.achievedAimsCount = [self.presentedAim getCompletedStepsCount];
	[self.pathView setNeedsDisplay];
}

@end
