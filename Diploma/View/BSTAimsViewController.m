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

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BSTAimsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.infiniteScrollActive = YES;
	[self setupDataForCollectionView];
	
	[self bindModel];
}

- (void)dealloc {
	self.catalogsCollectionView.delegate = nil;
	self.catalogsCollectionView.dataSource = nil;
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
}

-(void)setupDataForCollectionView {
	
	// Create the original set of data
	NSArray *originalArray = @[@"itemOne", @"itemTwo", @"itemThree"];
	
	// Grab references to the first and last items
	// They're typed as id so you don't need to worry about what kind
	// of objects the originalArray is holding
	id firstItem = originalArray[0];
	id lastItem = [originalArray lastObject];
	
	NSMutableArray *workingArray = [originalArray mutableCopy];
	
	// Add the copy of the last item to the beginning
	[workingArray insertObject:lastItem atIndex:0];
	
	// Add the copy of the first item to the end
	[workingArray addObject:firstItem];
	
	// Update the collection view's data source property
	self.dataArray = [NSArray arrayWithArray:workingArray];
}

#pragma mark - <UIScrollViewDelegate>


- (void)bindModel{
}

#pragma mark - UITableViewDataSource / UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = ClassReuseID(BSTAimCell);
	
	BSTAimCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	
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
	return self.dataArray.count * (self.infiniteScrollActive ? INFINITE_COUNT_MULTIPLIER : 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = ClassReuseID(BSTCategoryNameCell);
	
	BSTCategoryNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId forIndexPath:indexPath];
	cell.label.text = @"Item";
	//id dbEntity   = [self sectionAtIndexPath:indexPath];
	//cell.dbEntity = dbEntity;
	//cell.active   = [self.viewModel.selectedCategory isEqual:dbEntity];
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
	
	id section    = [self sectionAtIndexPath:indexPath];
	id oldSection = self.viewModel.selectedCategory;
	
	if (oldSection != section) {
		[self selectSection:section afterSection:oldSection];
		self.viewModel.selectedCategory = section;
	}
}

#pragma mark - Private

- (id)sectionAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger index = indexPath.row % self.viewModel.categories.count;
	return self.viewModel.categories[index];
}

- (void)selectSection:(id)section afterSection:(id)oldSection {
	if (oldSection) {
		[self setSelected:NO forSectionAtIndex:[self.viewModel.categories indexOfObject:oldSection]];
	}
	if (section) {
		[self setSelected:YES forSectionAtIndex:[self.viewModel.categories indexOfObject:section]];
	}
}

- (void)setSelected:(BOOL)selected forSectionAtIndex:(NSUInteger)index {
	NSUInteger const count = self.viewModel.categories.count;
	NSArray *const visible = [self.catalogsCollectionView indexPathsForVisibleItems];
	
	for (NSUInteger page = 0; page < 3; ++page) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(count * page + index) inSection:0];
		if ([visible containsObject:indexPath]) {
			BSTCategoryNameCell *cell = (BSTCategoryNameCell *)[self.catalogsCollectionView cellForItemAtIndexPath:indexPath];
			//cell.active = selected;
		}
	}
}


@end
