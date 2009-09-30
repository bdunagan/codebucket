//
//  SyncingArrows_iPhoneAppDelegate.m
//  SyncingArrows_iPhone
//
//  Created by Brian Dunagan on 9/27/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

#import "SyncingArrows_iPhoneAppDelegate.h"
#import "SyncingArrows_iPhoneViewController.h"

@implementation SyncingArrows_iPhoneAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
