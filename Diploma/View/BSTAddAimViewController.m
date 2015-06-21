//
//  BSTAddAimViewController.m
//  Diploma
//
//  Created by Maria on 05.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAddAimViewController.h"
#import "BSTChangeAimViewModel.h"
#import <AKPickerView/AKPickerView.h>

@interface BSTAddAimViewController () <AKPickerViewDelegate, AKPickerViewDataSource>

/** Outlets **/
@property (weak, nonatomic) IBOutlet UITextField     *aimTitleTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIView          *categoriesPanel;

/** Custom properties **/
@property (strong, nonatomic) BSTChangeAimViewModel *viewModel;
@property (nonatomic, strong) AKPickerView          *pickerView;
@property (nonatomic, strong) NSArray               *categories;

@end

@implementation BSTAddAimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self addKeyboardHidingGesture];
	[super addAppTitle];
	
	self.pickerView = [[AKPickerView alloc] initWithFrame:CGRectMake(0, 0, self.categoriesPanel.frame.size.width, self.categoriesPanel.frame.size.height)];
	self.pickerView.delegate = self;
	self.pickerView.dataSource = self;
	self.pickerView.interitemSpacing = 10;
	[self.categoriesPanel addSubview:self.pickerView];
	
	[self bindViewModel];
}

- (void)bindViewModel {
	self.viewModel = [BSTChangeAimViewModel new];
	
	if (self.selectedAim) {
		self.viewModel.objectId = self.selectedAim.id;
		self.aimTitleTextField.text = self.selectedAim.title;
	}
	else {
		self.viewModel.objectId = nil;
	}
	RAC(self.viewModel, aimTitle) = self.aimTitleTextField.rac_textSignal;
	
	@weakify(self);
	
	[[[self.itemsObserver replayLast] deliverOnMainThread] subscribeNext:^(NSArray *items) {
		@strongify(self);
		self.categories = items;
		[self.pickerView reloadData];
	}];
}

- (RACSignal *)itemsObserver {
	return RACObserve(self.viewModel, categories);
}

#pragma mark - PikerViewDelegate

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView {
	return self.categories.count;
}

- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item {
	BSTCategory *element = (BSTCategory *)self.categories[item];
	return element.title;
}

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item {
	self.viewModel.selectedCategory = self.categories[item];
}

#pragma mark - IBActions

- (IBAction)addButtonTouch:(id)sender {
	[UIView performWithoutAnimation:^{
		[self.aimTitleTextField endEditing:YES];
	}];
	[[self.viewModel.executeAimChanging execute:nil] subscribeCompleted:^{
		[self.viewModel saveChanges];
		[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
	}];
}


- (IBAction)cancelButtonTouch:(id)sender {
	[self.viewModel rollbackChanges];
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
