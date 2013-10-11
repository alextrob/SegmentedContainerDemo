//
//  CollectionViewController.m
//  SegmentedContainerDemo
//
//  Created by Alex Robinson on 10/10/2013.
//  Copyright (c) 2013 Alex Robinson. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation CollectionViewController

static NSString *ReuseIdentifier = @"Cell";

- (id)init {
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if (self) {
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ReuseIdentifier];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.collectionView setBackgroundColor:[UIColor yellowColor]];
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
	[self.collectionView addSubview:self.refreshControl];		
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)refreshControlValueChanged:(id)sender {
	[self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:5];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self fixInsets];
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	[super willMoveToParentViewController:parent];
	[self fixInsets];
}

- (void)fixInsets {
	UIViewController *parent = self.parentViewController;
	if (parent) {
		CGFloat top = parent.topLayoutGuide.length;
        CGFloat bottom = parent.bottomLayoutGuide.length;
		CGFloat offsetY = self.collectionView.contentOffset.y;
		if (offsetY == 0) {
			self.collectionView.contentOffset = CGPointMake(self.collectionView.contentOffset.x, offsetY - top);
		}
		// Adapted from http://stackoverflow.com/q/19038949/99714
		UIEdgeInsets newInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
        if (self.collectionView.contentInset.top != top && !self.refreshControl.isRefreshing) {
			self.collectionView.contentInset = newInsets;
			self.collectionView.scrollIndicatorInsets = newInsets;
        }
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
	[cell setBackgroundColor:[UIColor redColor]];
	return cell;
}

@end
