//
//  SyncingArrows_iPhoneAppDelegate.h
//  SyncingArrows_iPhone
//
//  Created by Brian Dunagan on 9/27/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SyncingArrows_iPhoneViewController;

@interface SyncingArrows_iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SyncingArrows_iPhoneViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SyncingArrows_iPhoneViewController *viewController;

@end

