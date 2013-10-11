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

- (id)init {
	self = [super init];
	if (self) {
		
		CollectionViewController *vc1 = [[CollectionViewController alloc] init];
		[vc1 setTitle:@"View 1"];
		
		ContentsViewController *vc2 = [[ContentsViewController alloc] initWithStyle:UITableViewStylePlain];
		[vc2 setCellColor:[UIColor blueColor]];
		[vc2 setTitle:@"View 2"];
		
		CollectionViewController *vc3 = [[CollectionViewController alloc] init];
		[vc3 setTitle:@"View 3"];
		
		ContentsViewController *vc4 = [[ContentsViewController alloc] initWithStyle:UITableViewStylePlain];
		[vc4 setCellColor:[UIColor greenColor]];
		[vc4 setTitle:@"View 4"];
				
		[self setChildViewControllers:@[vc1,
										vc2,
										vc3,
										vc4]];
		
		NSMutableArray *titles = [NSMutableArray arrayWithCapacity:self.childViewControllers.count];
		for (ContentsViewController *vc in self.childViewControllers) {
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
			[viewController didMoveToParentViewController:self];
			self.currentViewController = viewController;
		}];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
