//
//  UIScrollView_in_UIScrollViewAppDelegate.h
//  UIScrollView_in_UIScrollView
//
//  Created by Brian Dunagan on 12/8/08.
//  Copyright bdunagan.com 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView_in_UIScrollViewAppDelegate : NSObject <UIApplicationDelegate> {
	
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

