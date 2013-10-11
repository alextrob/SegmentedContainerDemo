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
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	[super willMoveToParentViewController:parent];
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
