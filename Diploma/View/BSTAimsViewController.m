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

#define INFINITE_OFFSET_MULTIPLIER .8
#define INFINITE_COUNT_MULTIPLIER  3

@interface BSTAimsViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *catalogsCollectionView;
@property (weak, nonatomic) IBOutlet UITableView      *tableView;

@property (nonatomic, assign) BOOL infiniteScrollActive;

@property (nonatomic, strong) BSTAimViewModel *viewModel;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *categories;

@end

@implementation BSTAimsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[super addAppTitle];
	self.infiniteScrollActive = YES;
	
	[self bindModel];
}

- (void)dealloc {
	self.catalogsCollectionView.delegate = nil;
	self.catalogsCollectionView.dataSource = nil;
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
}

- (RACSignal *)itemsObserver {
	return RACObserve(self.viewModel, aims);
}

- (RACSignal *)collectionItemsObserver {
	return RACObserve(self.viewModel, categories);
}

#pragma mark - <UIScrollViewDelegate>


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
		[self.catalogsCollectionView reloadData];
	}];
}
- (IBAction)addEntity:(id)sender {
	NSMutableDictionary *aimInfo = [[NSMutableDictionary alloc] init];
	[aimInfo setValue:@"test" forKey:@"title"];
	[self.viewModel addAim:aimInfo intoCategory:nil];
}

#pragma mark - UITableViewDataSource / UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//return self.items.count;
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = ClassReuseID(BSTAimCell);
	
	BSTAimCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	//cell.dbEntity = self.items[indexPath.row];
	
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (scrollView == self.catalogsCollectionView && self.infiniteScrollActive) {
		CGFloat const contentWidth = scrollView.contentSize.width / INFINITE_COUNT_MULTIPLIER;
		CGFloat const leftBorder   = contentWidth * (1. - INFINITE_OFFSET_MULTIPLIER);
		CGFloat const rightBorder  = contentWidth * (1. + INFINITE_OFFSET_MULTIPLIER);
		CGPoint const offset       = scrollView.contentOffset;
		
		if (offset.x < leftBorder) {
			// Jump to the left
			scrollView.contentOffset = (CGPoint){contentWidth + leftBorder, offset.y};
		}
		else if (offset.x > rightBorder) {
			// Jump to the right
			scrollView.contentOffset = (CGPoint){rightBorder - contentWidth, offset.y};
		}
	}
}

#pragma mark - UICollectionViewDataSource / UICollectionViewDelegate

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//	return CGSizeMake([FWGenreNameCell widthForDBEntity:[self sectionAtIndexPath:indexPath]], collectionViewLayout.itemSize.height - .1);
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	//return self.categories.count * (self.infiniteScrollActive ? INFINITE_COUNT_MULTIPLIER : 1);
	return 10 * (self.infiniteScrollActive ? INFINITE_COUNT_MULTIPLIER : 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = ClassReuseID(BSTCategoryNameCell);
	
	BSTCategoryNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
	cell.label.text = @"Item";
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

@end
