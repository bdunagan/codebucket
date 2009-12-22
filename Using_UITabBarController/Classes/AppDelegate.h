//
//  AppDelegate.h
//  Using_UITabBarController
//
//  Created by Brian Dunagan on 12/21/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
