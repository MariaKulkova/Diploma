//
//  BSTStepViewController.m
//  Diploma
//
//  Created by Maria on 10.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTStepViewController.h"
#import "Macroses.h"
#import "BSTStepCell.h"
#import "BSTSegmentedControl.h"
#import "BSTProgressViewController.h"
#import "BSTStepViewModel.h"
#import "BSTAddStepViewController.h"

@interface BSTStepViewController () <UITableViewDelegate, UITableViewDataSource, SwipeableCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView         *tableView;
@property (weak, nonatomic) IBOutlet UIView              *progressView;
@property (weak, nonatomic) IBOutlet BSTSegmentedControl *segmentedControl;

@property (nonatomic, strong) BSTStepViewModel *viewModel;
@property (nonatomic, strong) NSArray *items;

@end

@implementation BSTStepViewController

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
	self.viewModel = [BSTStepViewModel new];
	@weakify(self);
	self.viewModel.selectedAim = self.selectedAim;
	
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"ProgressSegue"]) {
		BSTProgressViewController *embeded = (BSTProgressViewController *)[segue destinationViewController];
		embeded.presentedAim = self.selectedAim;
	}
	else if ([segue.identifier isEqualToString:@"AddStepSegue"]) {
		BSTAddStepViewController *viewController = (BSTAddStepViewController *)[segue destinationViewController];
		if ([sender isKindOfClass:[UIBarButtonItem class]] ) {
			viewController.selectedStep = nil;
		}
		else if ([sender isKindOfClass:[BSTStepCell class]]) {
			BSTStepCell *cell = (BSTStepCell *)sender;
			viewController.selectedStep = cell.dbEntity;
		}
		viewController.selectedAim = self.selectedAim;
	}
}

- (RACSignal *)itemsObserver {
	return RACObserve(self.viewModel, steps);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = ClassReuseID(BSTStepCell);
	
	BSTStepCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	cell.delegate = self;
	cell.dbEntity = self.items[indexPath.row];
	
	return cell;
}

- (void)deleteActionForSwipeableCell:(BSTStepCell *)swipeableCell {
	[self.viewModel deleteStep:swipeableCell.dbEntity];
}

- (void)completeActionForSwipeableCell:(BSTStepCell *)swipeableCell {
	swipeableCell.completed = YES;
	[self.viewModel completeStep:swipeableCell.dbEntity];
}

- (IBAction)segmentedControllIndexChanged:(id)sender {
	switch (self.segmentedControl.selectedSegmentIndex) {
		case 0:
			self.tableView.hidden = true;
			self.progressView.hidden = false;
			if ([self.childViewControllers.lastObject isKindOfClass:[BSTProgressViewController class]]) {
				BSTProgressViewController *progressController = (BSTProgressViewController *)self.childViewControllers.lastObject;
				[progressController reloadData];
			}
			break;
		case 1:
			self.tableView.hidden = false;
			self.progressView.hidden = true;
			break;
		default:
			break;
	}
}

@end
