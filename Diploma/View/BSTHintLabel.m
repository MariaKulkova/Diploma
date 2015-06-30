//
//  BSTHintLabel.m
//  Diploma
//
//  Created by Maria on 30.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTHintLabel.h"

@implementation BSTHintLabel

- (void)setHintText:(NSString *)hintText {
	NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:@"* "];
	UIFont *font=[UIFont fontWithName:@"Helvetica-Neue" size:12.0f];
	[hintString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, hintString.length)];
	[hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, hintString.length)];
	
	NSMutableAttributedString *hintTextString=[[NSMutableAttributedString alloc] initWithString:hintText];
	[hintString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, hintTextString.length)];
	[hintString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, hintTextString.length)];
	
	[hintString appendAttributedString:hintTextString];
	self.text = [hintString mutableString];
}

@end
