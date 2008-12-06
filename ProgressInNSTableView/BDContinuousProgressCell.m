//
//  BDContinuousProgressCell.m
//  ProgressInNSTableView
//
//  Created by Brian Dunagan on 12/6/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import "BDContinuousProgressCell.h"

@implementation BDContinuousProgressCell

@synthesize progress;

- (void)drawInteriorWithFrame:(NSRect)aRect inView:(NSView *)controlView
{
	[super drawInteriorWithFrame:aRect inView:controlView];

	NSRect progressRect = NSMakeRect(aRect.origin.x, aRect.origin.y, aRect.size.width, aRect.size.height);
	progressRect.origin.x += 20;
	[progress setFrame:progressRect];
	[progress sizeToFit];
}

- (void)setProgress:(NSProgressIndicator *)newProgress
{
	[newProgress retain];
	[progress release];
	progress = newProgress;
	
	[progress sizeToFit];
}

@end
