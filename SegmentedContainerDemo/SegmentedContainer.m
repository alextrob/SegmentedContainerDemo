//
//  SegmentedContainer.m
//  SegmentedContainerDemo
//
//  Created by Alex Robinson on 9/10/2013.
//  Copyright (c) 2013 Alex Robinson. All rights reserved.
//

#import "SegmentedContainer.h"
#import "ContentsViewController.h"
#import "CollectionViewController.h"

@interface SegmentedContainer ()

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *childViewControllers;

@property (weak, nonatomic) UIViewController *currentViewController;

@end

@implementation SegmentedContainer

- (id)initWithChildViewControllers:(NSArray *)childViewControllers {
	self = [super init];
	if (self) {
		
		[self setChildViewControllers:childViewControllers];
		
		NSMutableArray *titles = [NSMutableArray arrayWithCapacity:self.childViewControllers.count];
		for (UIViewController *vc in self.childViewControllers) {
			[titles addObject:[vc.title copy]];
		}
		self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithArray:titles]];
		[self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
		[self.navigationItem setTitleView:self.segmentedControl];
		
		[self.segmentedControl setSelectedSegmentIndex:0];
		[self segmentedControlValueChanged:self.segmentedControl]; // manually called for setup.
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)segmentedControlValueChanged:(id)sender {
	
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.segmentedControl.selectedSegmentIndex];
	
	if (self.currentViewController == viewController) {
		return;
	}
	
	if (!self.currentViewController) {
		// first time a segment is selected
		[self addChildViewController:viewController];
		[viewController.view setFrame:self.view.bounds];
		[self.view addSubview:viewController.view];
		[self fixInsets:viewController];
		[viewController didMoveToParentViewController:self];
		self.currentViewController = viewController;
	}
	else {
		// swap the existing view with the newly selected one
		[self.currentViewController willMoveToParentViewController:nil];
		[self addChildViewController:viewController];
		
		[self transitionFromViewController:self.currentViewController toViewController:viewController duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
			//
		} completion:^(BOOL finished) {
			
			[viewController.view setFrame:self.view.bounds];
			
			[self.currentViewController removeFromParentViewController];
			[self fixInsets:viewController];
			[viewController didMoveToParentViewController:self];
			self.currentViewController = viewController;
		}];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[self fixInsets:self.currentViewController];
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)fixInsets:(UIViewController *)viewController {
	UIScrollView *collectionOrTableView;
	if ([viewController isKindOfClass:[UITableViewController class]]) {
		collectionOrTableView = [(UITableViewController *)viewController tableView];
	}
	else if ([viewController isKindOfClass:[UICollectionViewController class]]) {
		collectionOrTableView = [(UICollectionViewController *)viewController collectionView];
	}
	else {
		return;
	}
	
	UIRefreshControl *refreshControl;
	if ([viewController respondsToSelector:@selector(refreshControl)]) {
		refreshControl = [(id)viewController refreshControl];
	}
	
	if (collectionOrTableView) {
		CGFloat top = self.topLayoutGuide.length;
        CGFloat bottom = self.bottomLayoutGuide.length;
		CGFloat offsetY = collectionOrTableView.contentOffset.y;
		if (offsetY == 0) {
			collectionOrTableView.contentOffset = CGPointMake(collectionOrTableView.contentOffset.x, offsetY - top);
		}
		
		UIEdgeInsets newInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
        if (collectionOrTableView.contentInset.top != top) {
			// if there's no refresh control OR there's a refresh control but it *isn't* refreshing.
			if (!refreshControl || (refreshControl && !refreshControl.isRefreshing)) {
				[UIView animateWithDuration:0.3f animations:^{
					collectionOrTableView.contentInset = newInsets;
					collectionOrTableView.scrollIndicatorInsets = newInsets;
				} completion:^(BOOL finished) {
					//
				}];
			}
        }
	}
}

@end
