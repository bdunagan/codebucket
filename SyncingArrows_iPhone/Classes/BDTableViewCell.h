//
//  BDTableViewCell.h
//  SyncingArrows_iPhone
//
//  Created by Brian Dunagan on 9/27/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDTableViewCell : UITableViewCell {
	UIImageView *syncIconView;
	UILabel *titleLabel;
	
	
}

@property (nonatomic, retain) IBOutlet UIImageView *syncIconView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

- (void)setAnimationMode:(BOOL)isArrayAnimation withInterval:(float)interval;

@end
