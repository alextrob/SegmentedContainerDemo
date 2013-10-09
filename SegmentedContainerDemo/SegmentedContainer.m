//
//  SegmentedContainer.m
//  SegmentedContainerDemo
//
//  Created by Alex Robinson on 9/10/2013.
//  Copyright (c) 2013 Alex Robinson. All rights reserved.
//

#import "SegmentedContainer.h"
#import "ContentsViewController.h"

@interface SegmentedContainer ()

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray *childViewControllers;

@property (weak, nonatomic) ContentsViewController *currentViewController;

@end

@implementation SegmentedContainer

- (id)init {
	self = [super init];
	if (self) {
		
		ContentsViewController *vc1 = [[ContentsViewController alloc] initWithStyle:UITableViewStylePlain];
		[vc1 setCellColor:[UIColor blueColor]];
		[vc1 setTitle:@"View 1"];
		
		ContentsViewController *vc2 = [[ContentsViewController alloc] initWithStyle:UITableViewStylePlain];
		[vc2 setCellColor:[UIColor greenColor]];
		[vc2 setTitle:@"View 2"];
				
		[self setChildViewControllers:@[vc1, vc2]];
		
		NSMutableArray *titles = [NSMutableArray arrayWithCapacity:self.childViewControllers.count];
		for (ContentsViewController *vc in self.childViewControllers) {
			[self addChildViewController:vc];
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
	
	[self setAutomaticallyAdjustsScrollViewInsets:NO];
//	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)segmentedControlValueChanged:(id)sender {
	ContentsViewController *viewController = [self.childViewControllers objectAtIndex:self.segmentedControl.selectedSegmentIndex];
	
	if (self.currentViewController == viewController) {
		return;
	}
	
	if (!self.currentViewController) {
		// first time a segment is selected
		[viewController.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
		[viewController.view setFrame:self.view.frame];
		[self.view addSubview:viewController.view];
	}
	else {
		// swap the existing view with the newly selected one
		
		
		[viewController.view setFrame:self.currentViewController.view.frame];
		[viewController.tableView setContentInset:self.currentViewController.tableView.contentInset];
		[viewController.tableView setScrollIndicatorInsets:self.currentViewController.tableView.scrollIndicatorInsets];
	
		[self transitionFromViewController:self.currentViewController toViewController:viewController duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
			//
		} completion:^(BOOL finished) {
			//
		}];
	}
	
	self.currentViewController = viewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
