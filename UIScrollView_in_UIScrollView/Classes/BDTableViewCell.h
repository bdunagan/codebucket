//
//  BDTableViewCell.h
//  UIScrollView_in_UIScrollView
//
//  Created by Brian Dunagan on 12/8/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BDTableViewCell : UITableViewCell {
	UITextView *textView;
}

@property (nonatomic, retain) UITextView *textView;
@end
