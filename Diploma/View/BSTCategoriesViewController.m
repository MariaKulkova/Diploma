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
	
	[self bindModel];
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
	// Return YES if you want the specified item to be editable.
	return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		//add code here for when you hit delete
		// TODO: delete cell
	}
}

#pragma mark - Segues

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue {
	if ([segue.sourceViewController isKindOfClass:[BSTAddCategoryViewController class]]) {
		BSTAddCategoryViewController *addCategoryViewConroller = segue.sourceViewController;
		if (addCategoryViewConroller.categoryTitle) {
			NSMutableDictionary *categoryInfo = [[NSMutableDictionary alloc] init];
			[categoryInfo setObject:addCategoryViewConroller.categoryTitle forKey:@"title"];
			[self.viewModel addCategory:categoryInfo];
		}
	}
}

@end
