//
//  BSTCollectionViewCategoriesLayout.m
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTCollectionViewCategoriesLayout.h"

@implementation BSTCollectionViewCategoriesLayout

- (void)awakeFromNib {
	[super awakeFromNib];
	
	// Only horizontal scroll direction is supported for now
	self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
	
	if (self.centerItems) {
		CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.bounds);
		NSInteger itemsInRow = [attributes count];
		
		// x-x-x-x ... sum up the interim space
		CGFloat aggregateInteritemSpacing = self.minimumInteritemSpacing * (itemsInRow -1);
		
		// Sum the width of all elements in the row
		CGFloat aggregateItemWidths = 0.f;
		for (UICollectionViewLayoutAttributes *itemAttributes in attributes) {
			aggregateItemWidths += CGRectGetWidth(itemAttributes.frame);
		}
		
		// Build an alignment rect
		// |==|--------|==|
		CGFloat alignmentWidth = aggregateItemWidths + aggregateInteritemSpacing;
		CGFloat alignmentXOffset = (collectionViewWidth - alignmentWidth) / 2.f;
		
		// Adjust each item's position to be centered
		CGRect previousFrame = CGRectZero;
		for (UICollectionViewLayoutAttributes *itemAttributes in attributes) {
			CGRect itemFrame = itemAttributes.frame;
			
			if (CGRectEqualToRect(previousFrame, CGRectZero)) {
				itemFrame.origin.x = alignmentXOffset;
			} else {
				itemFrame.origin.x = CGRectGetMaxX(previousFrame) + self.minimumInteritemSpacing;
			}
			
			itemAttributes.frame = itemFrame;
			previousFrame = itemFrame;
		}
	}
	
	return attributes;
}

#pragma mark - Custom setters/getters

- (void)setCenterItems:(BOOL)center {
	BOOL changed = (_centerItems != center);
	_centerItems = center;
	
	if (changed) {
		[self invalidateLayout];
	}
}


@end
