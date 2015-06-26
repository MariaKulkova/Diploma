//
//  BSTAimsViewController.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAimsViewController.h"
#import "Macroses.h"
#import "BSTAimCell.h"
#import "BSTAimViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BSTCollectionViewCategoriesLayout.h"
#import "BSTCategoryNameCell.h"
#import "BSTAddAimViewController.h"
#import "BSTStepViewController.h"
#import <AKPickerView/AKPickerView.h>

#define INFINITE_OFFSET_MULTIPLIER .8
#define INFINITE_COUNT_MULTIPLIER  3

@interface BSTAimsViewController () <UITableViewDelegate, UITableViewDataSource, AKPickerViewDelegate, AKPickerViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView      *categoriesPanel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) BSTAimViewModel *viewModel;
@property (nonatomic, strong) AKPickerView    *pickerView;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *categories;

@end

@implementation BSTAimsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[super addAppTitle];
	
	self.pickerView = [[AKPickerView alloc] initWithFrame:CGRectMake(0, 0, self.categoriesPanel.frame.size.width, self.categoriesPanel.frame.size.height)];
	self.pickerView.delegate = self;
	self.pickerView.dataSource = self;
	self.pickerView.interitemSpacing = 10;
	[self.categoriesPanel addSubview:self.pickerView];
	
	[self bindModel];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.viewModel updateData];
}

- (void)dealloc {
	self.pickerView.delegate = nil;
	self.pickerView.dataSource = nil;
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
}

- (RACSignal *)itemsObserver {
	return RACObserve(self.viewModel, aims);
}

- (RACSignal *)collectionItemsObserver {
	return RACObserve(self.viewModel, categories);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"AddAimSegue"]) {
		BSTAddAimViewController *viewController = segue.destinationViewController;
		if ([sender isKindOfClass:[UIBarButtonItem class]] ) {
			viewController.selectedAim = nil;
		}
		else if ([sender isKindOfClass:[BSTAimCell class]]) {
			BSTAimCell *cell = (BSTAimCell *)sender;
			viewController.selectedAim = cell.dbEntity;
		}
	}
	else if ([segue.identifier isEqualToString:@"PerformStepsSegue"]){
		BSTStepViewController *viewController = segue.destinationViewController;
		BSTAimCell *cell = (BSTAimCell *)sender;
		viewController.selectedAim = cell.dbEntity;
	}
}

- (IBAction)longCellPress:(UILongPressGestureRecognizer *)sender {
	CGPoint position = [sender locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:position];
	[self performSegueWithIdentifier:@"AddAimSegue" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
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

#pragma mark - Bingings

- (void)bindModel{
	self.viewModel = [BSTAimViewModel new];
	@weakify(self);
	
	[[[self.itemsObserver replayLast] deliverOnMainThread] subscribeNext:^(NSArray *items) {
		@strongify(self);
		self.items = items;
		[self.tableView reloadData];
	}];
	
	[[[self.collectionItemsObserver replayLast] deliverOnMainThread] subscribeNext:^(NSArray *items) {
		@strongify(self);
		self.categories = items;
		[self.pickerView reloadData];
	}];
}

#pragma mark - UITableViewDataSource / UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = ClassReuseID(BSTAimCell);
	
	BSTAimCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	cell.dbEntity = self.items[indexPath.row];
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		BSTAimCell *deletedCell = (BSTAimCell *)[self.tableView cellForRowAtIndexPath:indexPath];
		[self.viewModel deleteAim:deletedCell.dbEntity];
	}
}

@end
