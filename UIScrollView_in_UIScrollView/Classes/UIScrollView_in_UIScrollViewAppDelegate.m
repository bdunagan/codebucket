//
//  UIScrollView_in_UIScrollViewAppDelegate.m
//  UIScrollView_in_UIScrollView
//
//  Created by Brian Dunagan on 12/8/08.
//  Copyright bdunagan.com 2008. All rights reserved.
//

#import "UIScrollView_in_UIScrollViewAppDelegate.h"
#import "RootViewController.h"


@implementation UIScrollView_in_UIScrollViewAppDelegate

@synthesize window;
@synthesize navigationController;


- (id)init {
	if (self = [super init]) {
		// 
	}
	return self;
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
