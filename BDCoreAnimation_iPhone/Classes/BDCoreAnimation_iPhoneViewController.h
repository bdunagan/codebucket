//
//  BDCoreAnimation_iPhoneViewController.h
//  BDCoreAnimation_iPhone
//
//  Created by Brian Dunagan on 4/26/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDCoreAnimation_iPhoneViewController : UIViewController {
	IBOutlet UIView *mainView;
	IBOutlet UITableView *list;
	IBOutlet UIView *topView;
	IBOutlet UIImageView *iconView;
	UIImage *icon;
	UIImageView *animatedIconView;
	UIView *yellowFadeView;
}

- (void)animateIcon;

@end
