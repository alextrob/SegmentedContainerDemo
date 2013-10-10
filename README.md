SegmentedContainerDemo
======================

![Screenshot showing portrait, refreshing](https://raw.github.com/alextrob/SegmentedContainerDemo/master/screenshot-1.png)
![Screenshot showing landscape, refreshing](https://raw.github.com/alextrob/SegmentedContainerDemo/master/screenshot-2.png)

This is a sample/demo for using a `UISegmentedControl` in a `UINavigationBar` to switch between child `UITableViewController`s that have `UIRefreshControl`s enabled, while still allowing content to blur behind the navigation bar in iOS 7. It's iOS 7-only, so you'd probably want to add some conditions to support older versions.

The problem I was running into was that the first view controller would display perfectly fine, with the top of the first cell sitting right at the bottom of the navigation bar. Subsequent child view controllers would have the first cell displaying up underneath the statusbar.

It appears that the `automaticallyAdjustsScrollViewInsets` property works on the first child view controller, but not subsequent view controllers.

The closest answer I could find is [here on StackOverflow](http://stackoverflow.com/questions/19038949/content-falls-beneath-navigation-bar-when-embedded-in-custom-container-view-cont), but rotation and refresh didn't quite work.
