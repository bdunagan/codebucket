//
//  BDCoreAnimation_iPhoneAppDelegate.h
//  BDCoreAnimation_iPhone
//
//  Created by Brian Dunagan on 4/26/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BDCoreAnimation_iPhoneViewController;

@interface BDCoreAnimation_iPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BDCoreAnimation_iPhoneViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BDCoreAnimation_iPhoneViewController *viewController;

@end
