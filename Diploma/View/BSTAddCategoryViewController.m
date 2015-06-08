//
//  BSTAddCategoryViewController.m
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAddCategoryViewController.h"
#import "BSTCategoriesViewController.h"

@interface BSTAddCategoryViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@end

@implementation BSTAddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)cancelButtonTouch:(id)sender {
	_categoryTitle = nil;
	[self performSegueWithIdentifier:@"goBackSegue" sender:self];
}

- (IBAction)saveButtonTouch:(id)sender {
	_categoryTitle = self.titleTextField.text;
	[self performSegueWithIdentifier:@"goBackSegue" sender:self];
}

@end
