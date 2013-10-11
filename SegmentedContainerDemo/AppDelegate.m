//
//  AppDelegate.m
//  SegmentedContainerDemo
//
//  Created by Alex Robinson on 9/10/2013.
//  Copyright (c) 2013 Alex Robinson. All rights reserved.
//

#import "AppDelegate.h"
#import "SegmentedContainer.h"
#import "ContentsViewController.h"
#import "CollectionViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
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
	
	SegmentedContainer *container = [[SegmentedContainer alloc] initWithChildViewControllers:@[vc1, vc2, vc3, vc4]];
	[container setTitle:@"Container"];
	UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:container];
	
	CollectionViewController *collectionVC = [[CollectionViewController alloc] init];
	[collectionVC setTitle:@"Collection"];
	UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:collectionVC];

	ContentsViewController *contentsVC = [[ContentsViewController alloc] initWithStyle:UITableViewStylePlain];
	[contentsVC setCellColor:[UIColor orangeColor]];
	[contentsVC setTitle:@"Table"];
	UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:contentsVC];
	
	UITabBarController *tabBar = [[UITabBarController alloc] init];
	[tabBar setViewControllers:@[nav1, nav2, nav3]];

	[self.window setRootViewController:tabBar];
	
	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"blank"] forBarMetrics:UIBarMetricsDefault];
	
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
