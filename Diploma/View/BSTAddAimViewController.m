//
//  BSTAddAimViewController.m
//  Diploma
//
//  Created by Maria on 05.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAddAimViewController.h"
#import "BSTAimViewModel.h"

@interface BSTAddAimViewController ()

/** Outlets **/
@property (weak, nonatomic) IBOutlet UITextField *aimTitleTextField;

/** Custom properties **/
@property (strong, nonatomic) BSTAimViewModel *viewModel;

@end

@implementation BSTAddAimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self bindViewModel];
}

- (void)bindViewModel {
	self.viewModel = [BSTAimViewModel new];
}

- (IBAction)addButtonTouch:(id)sender {
	NSMutableDictionary *aimInfo = [[NSMutableDictionary alloc] init];
	[aimInfo setValue:self.aimTitleTextField.text forKey:@"title"];
	[self.viewModel addAim:aimInfo intoCategory:[NSNumber numberWithInt:1]];
	[self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cancelButtonTouch:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
