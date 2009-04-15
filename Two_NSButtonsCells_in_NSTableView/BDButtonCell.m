//
//  BDButtonCell.m
//  Two_NSButtonsCells_in_NSTableView
//
//  Created by Brian Dunagan on 4/14/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "BDButtonCell.h"

@implementation BDButtonCell

- (void)performClick:(id)sender {
	self;
	NSLog(@"clicked");
	[super performClick:sender];
}

@end
