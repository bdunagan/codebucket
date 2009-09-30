//
//  BDTableViewCell.m
//  SyncingArrows_iPhone
//
//  Created by Brian Dunagan on 9/27/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "BDTableViewCell.h"
#import <QuartzCore/CAAnimation.h>

@implementation BDTableViewCell

@synthesize syncIconView;
@synthesize titleLabel;

- (void)setAnimationMode:(BOOL)isArrayAnimation withInterval:(float)interval {
	if (isArrayAnimation) {
		// Animate using image array.
		syncIconView.animationImages = [NSArray arrayWithObjects:
										[[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows1" ofType:@"png"]] autorelease], 
										[[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows2" ofType:@"png"]] autorelease], 
										[[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows3" ofType:@"png"]] autorelease], 
										[[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows4" ofType:@"png"]] autorelease], 
										[[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows5" ofType:@"png"]] autorelease], 
										[[[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows6" ofType:@"png"]] autorelease], 
										nil];
		syncIconView.animationDuration = interval;
		syncIconView.animationRepeatCount = 0;
		[syncIconView startAnimating];
	}
	else {
		// Animate using rotate transform.
		CABasicAnimation* rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
		rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI];
		rotateAnimation.duration = interval;
		rotateAnimation.repeatCount = 1e100;
		[syncIconView.layer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
	}

	self.titleLabel.text = [NSString stringWithFormat:@"%@ at %1.2fs", (isArrayAnimation ? @"Array" : @"Rotate"), interval];
}

@end
