//
//  MainController.m
//  MenuBarItem
//
//  Created by Brian Dunagan on 12/23/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "MainController.h"

@implementation MainController

@synthesize statusItem;
@synthesize menu;
@synthesize menuItem;

- (void)awakeFromNib {
	// Setup menu bar item.
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:30] retain];
	[statusItem setMenu:menu];
	[statusItem setHighlightMode:YES];
	
	[statusItem setImage:[NSImage imageNamed:@"icon"]]; // icon should be 30x22
	menuItem.title = @"This is a menu item";
}

- (IBAction)openSystemPreferences:(id)sender {
	[[NSWorkspace sharedWorkspace] launchApplication:@"System Preferences"];
}

@end
