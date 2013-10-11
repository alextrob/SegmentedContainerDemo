//
//  ContentsViewController.m
//  SegmentedContainerDemo
//
//  Created by Alex Robinson on 9/10/2013.
//  Copyright (c) 2013 Alex Robinson. All rights reserved.
//

#import "ContentsViewController.h"

@interface ContentsViewController ()

@end

@implementation ContentsViewController

static NSString *ReuseIdentifier = @"Cell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseIdentifier];
    }
    return self;
}

- (void)viewWillLayoutSubviews {
	[self.view setFrame:self.parentViewController.view.frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor yellowColor]];
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSLog(@"%@ contentInset.top: %f", self.title, self.tableView.contentInset.top);
}

- (void)refreshControlValueChanged:(id)sender {
	[self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:5];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	[super willMoveToParentViewController:parent];
	[self fixInsets];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self fixInsets];
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)fixInsets {
	UIViewController *parent = self.parentViewController;
	if (parent) {
		CGFloat top = parent.topLayoutGuide.length;
        CGFloat bottom = parent.bottomLayoutGuide.length;
		CGFloat offsetY = self.tableView.contentOffset.y;
		if (offsetY == 0) {
			self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, offsetY - top);
		}
		// Adapted from http://stackoverflow.com/q/19038949/99714
		UIEdgeInsets newInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
        if (self.tableView.contentInset.top != top && !self.refreshControl.isRefreshing) {
			self.tableView.contentInset = newInsets;
			self.tableView.scrollIndicatorInsets = newInsets;
        }
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier forIndexPath:indexPath];
    
    [cell setBackgroundColor:self.cellColor];
	[cell.textLabel setText:[NSString stringWithFormat:@"%@:%i", ReuseIdentifier, indexPath.row]];
    
    return cell;
}

@end
