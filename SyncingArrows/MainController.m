//
//  MainController.m
//  SyncingArrows
//
//  Created by Brian Dunagan on 9/13/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "MainController.h"
#import "Item.h"

@implementation MainController

- (void)awakeFromNib {
	// Experiment with different update intervals.
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval)3] autorelease]];
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval)2] autorelease]];
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval)1] autorelease]];
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval).75] autorelease]];
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval).50] autorelease]];
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval).25] autorelease]];
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval).10] autorelease]];
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval).08] autorelease]]; // I prefer this one.
	[items addObject:[[[Item alloc] initWithInterval:(NSTimeInterval).05] autorelease]];
}

@end
