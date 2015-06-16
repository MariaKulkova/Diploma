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

@interface BSTStepViewController () <UITableViewDelegate, UITableViewDataSource, SwipeableCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView         *tableView;
@property (weak, nonatomic) IBOutlet UIView              *progressView;
@property (weak, nonatomic) IBOutlet BSTSegmentedControl *segmentedControl;

@property (nonatomic, assign) NSInteger count;

@end

@implementation BSTStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[super addAppTitle];
    // Do any additional setup after loading the view.
	self.count = 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = ClassReuseID(BSTStepCell);
	
	BSTStepCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	cell.delegate = self;
	//cell.dbEntity = self.items[indexPath.row];
	
	return cell;
}

- (void)deleteActionForSwipeableCell:(BSTStepCell *)swipeableCell {
	NSIndexPath *indexPath = [self.tableView indexPathForCell:swipeableCell];
	self.count--;
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)completeActionForSwipeableCell:(BSTStepCell *)swipeableCell {
	
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue {

}


- (IBAction)segmentedControllIndexChanged:(id)sender {
	switch (self.segmentedControl.selectedSegmentIndex) {
		case 0:
			self.tableView.hidden = true;
			self.progressView.hidden = false;
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
