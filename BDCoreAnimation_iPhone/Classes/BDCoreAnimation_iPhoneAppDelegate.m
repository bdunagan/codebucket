//
//  BDCoreAnimation_iPhoneAppDelegate.m
//  BDCoreAnimation_iPhone
//
//  Created by Brian Dunagan on 4/26/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

#import "BDCoreAnimation_iPhoneAppDelegate.h"
#import "BDCoreAnimation_iPhoneViewController.h"

@implementation BDCoreAnimation_iPhoneAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
