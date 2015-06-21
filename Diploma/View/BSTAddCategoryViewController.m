//
//  BSTAddCategoryViewController.m
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAddCategoryViewController.h"
#import "BSTCategoriesViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BSTChangeCategoryViewModel.h"

@interface BSTAddCategoryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong,nonatomic) NSArray *pickerViewArray;

@property (strong, nonatomic) BSTChangeCategoryViewModel *viewModel;

@end

@implementation BSTAddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self addKeyboardHidingGesture];
	[super addAppTitle];
	
	[self bindViewModel];
}

- (void)bindViewModel {
	self.viewModel = [BSTChangeCategoryViewModel new];
	
	RAC(self.viewModel, categoryTitle) = self.titleTextField.rac_textSignal;
	
	if (self.selectedCategory) {
		self.viewModel.objectId = self.selectedCategory.id;
		self.titleTextField.text = self.selectedCategory.title;
	}
	else {
		self.viewModel.objectId = nil;
	}
}

- (IBAction)saveButtonTouch:(id)sender {
	[UIView performWithoutAnimation:^{
		[self.titleTextField endEditing:YES];
	}];
	[[self.viewModel.executeCategoryChanging execute:nil] subscribeCompleted:^{
		[self.viewModel saveChanges];
		[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	}];
}

- (IBAction)cancelButtonTouch:(id)sender {
	[self.viewModel rollbackChanges];
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
