//
//  BDTableViewCell.m
//  UIScrollView_in_UIScrollView
//
//  Created by Brian Dunagan on 12/8/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import "BDTableViewCell.h"


@implementation BDTableViewCell

@synthesize textView;

- (void)setTextView:(UITextView *)newTextView
{
	textView = newTextView;
	[self.textView retain];
	[self.contentView addSubview:newTextView];
	[self layoutSubviews];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	CGRect contentRect = [self.contentView bounds];
	self.textView.frame  = CGRectMake(contentRect.origin.x + 5.0,
									  contentRect.origin.y + 5.0,
									  contentRect.size.width - (5.0*2),
									  contentRect.size.height - (5.0*2));
}

- (void)dealloc
{
    [textView release];
    [super dealloc];
}

@end
