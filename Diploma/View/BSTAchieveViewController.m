//
//  BSTAchieveViewController.m
//  Diploma
//
//  Created by Maria on 22.06.15.
//  Copyright (c) 2015 Maria. All rights reserved.
//

#import "BSTAchieveViewController.h"
#import "Macroses.h"

@interface BSTAchieveViewController () <UITableViewDataSource, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BSTAchieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[super addAppTitle];
}

#pragma mark - UITableViewDataSource / UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString * const reuseId = @"BSTAchieveCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	
	return cell;
}


@end
