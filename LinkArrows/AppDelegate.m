//
//  AppDelegate.m
//  LinkArrows
//
//  Copyright 2010 bdunagan.com. All rights reserved.
//

#import "AppDelegate.h"
#import "LinkArrowCell.h"

@implementation AppDelegate

@synthesize window;
@synthesize objects;
@synthesize tableView;

- (void)awakeFromNib {
	// Add some URL strings to an array for our model.
	objects = [[NSMutableArray alloc] init];
	[objects addObject:@"http://www.google.com"];
	[objects addObject:@"http://www.bing.com"];
	[objects addObject:@"http://www.yahoo.com"];
}

#pragma mark -
#pragma mark TableView Delegates

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
	return objects.count;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	return [objects objectAtIndex:rowIndex];
}

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	[aCell setAction:@selector(openFromLinkArrow:)];
	[aCell setLinkVisible:YES];
	// Uncomment to mimic iTunes' version of link arrows.
	// [aCell setLinkVisible:[tableView selectedRow] == rowIndex];
}

- (void)openFromLinkArrow:(id)sender {
	// Get the selected index.
	int selectedIndex = [tableView clickedRow];
	// Ignore indices out of range.
	if (selectedIndex < 0 && selectedIndex >= objects.count) return;

	// Get the selected URL and open in browser.
	NSString *selectedUrl = [objects objectAtIndex:selectedIndex];
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:selectedUrl]];
}

@end
