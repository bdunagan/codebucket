//
//  Item.m
//  SyncingArrows
//
//  Created by Brian Dunagan on 9/17/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize icon;
@synthesize title;

- (id) initWithInterval:(NSTimeInterval)interval {
	self = [super init];
	if (self != nil) {
		// Set item's title.
		self.title = [NSString stringWithFormat:@"Item with interval %1.2fs", interval];
		// Set up status array.
		icons = [[NSArray alloc] initWithObjects:
				 [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows1" ofType:@"png"]],
				 [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows2" ofType:@"png"]],
				 [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows3" ofType:@"png"]],
				 [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows4" ofType:@"png"]],
				 [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows5" ofType:@"png"]],
				 [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"syncing_arrows6" ofType:@"png"]],
				 nil];
		// Initialize icon state.
		icon = [icons objectAtIndex:0];
		statusState = 0;
		// Set up status timer.
		stateTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(updateStatus) userInfo:nil repeats:YES];
	}
	return self;
}

- (void)updateStatus {
	self.icon = [icons objectAtIndex:statusState];
	statusState = (statusState + 1) % [icons count];
}

- (void)dealloc {
	[stateTimer invalidate];
	stateTimer = nil;
	[icons release];
	[super dealloc];
}

@end
