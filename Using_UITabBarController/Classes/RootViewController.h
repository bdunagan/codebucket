//
//  RootViewController.h
//  Using_UITabBarController
//
//  Created by Brian Dunagan on 12/21/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

@interface RootViewController : UITableViewController {
	IBOutlet UITabBarController *tabBarController;
}

@property (nonatomic, retain) UITabBarController *tabBarController;

@end
