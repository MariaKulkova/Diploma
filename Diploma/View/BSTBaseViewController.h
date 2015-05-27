//
//  BSTBaseViewController.h
//  Diploma
//
//  Created by Maria on 25.05.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTBaseViewController : UIViewController

- (void)customInit;

- (void)addKeyboardHidingGesture;
- (void)hideKeyboard;

- (void)keyboardWillShow;
- (void)keyboardWillHide;

@end
