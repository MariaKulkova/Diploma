//
//  BSTCategoriesViewController.m
//  Diploma
//
//  Created by Maria on 08.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTCategoriesViewController.h"
#import "BSTAddCategoryViewController.h"
#import "BSTCategoryViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "Macroses.h"
#import "BSTCategoryCell.h"

@interface BSTCategoriesViewController () <UITableViewDelegate, UITableViewDataSource>

/** Outlets **/
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** Custom properties **/
@property (strong, nonatomic) BSTCategoryViewModel *viewModel;
@property (nonatomic, strong) NSArray              *items;

@end

@implementation BSTCategoriesViewController

#pragma mark - Init

- (void)viewDidLoad {
    [super viewDidLoad];
	[super addAppTitle];
	
	[self bindModel];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.viewModel updateData];
}

- (void)bindModel {
	self.viewModel = [BSTCategoryViewModel new];
	
	@weakify(self);
	
	[[[self.itemsObserver replayLast] deliverOnMainThread] subscribeNext:^(NSArray *items) {
		@strongify(self);
		self.items = items;
		[self.tableView reloadData];
	}];
}

- (void)dealloc {
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
}

- (RACSignal *)itemsObserver {
	return RACObserve(self.viewModel, categories);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"AddCategorySegue"]) {
		BSTAddCategoryViewController *viewController = segue.destinationViewController;
		if ([sender isKindOfClass:[UIBarButtonItem class]] ) {
			viewController.selectedCategory = nil;
		}
		else if ([sender isKindOfClass:[BSTCategoryCell class]]) {
			BSTCategoryCell *cell = (BSTCategoryCell *)sender;
			viewController.selectedCategory = cell.dbEntity;
		}
	}
}

- (IBAction)longCellPress:(UILongPressGestureRecognizer *)sender {
	CGPoint position = [sender locationInView:self.tableView];
	NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:position];
	[self performSegueWithIdentifier:@"AddCategorySegue" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - UITableViewDataSource / UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = ClassReuseID(BSTCategoryCell);
	
	BSTCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	cell.dbEntity = self.items[indexPath.row];
	
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		BSTCategoryCell *deletedCell = (BSTCategoryCell *)[self.tableView cellForRowAtIndexPath:indexPath];
		[self.viewModel deleteCategory:deletedCell.dbEntity];
	}
}

@end
