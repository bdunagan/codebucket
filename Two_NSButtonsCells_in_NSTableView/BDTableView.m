//
//  BDTableView.m
//  Two_NSButtonsCells_in_NSTableView
//
//  Created by Brian Dunagan on 4/14/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "BDTableView.h"

@implementation BDTableView

- (void)keyDown:(NSEvent *)event {
	// Accept space bar only.
	if([event type] == NSKeyDown && [event keyCode] == 49) {

		/*
		 * Call custom selector in delegate
		 */

		if ([[self delegate] respondsToSelector:@selector(performClickForView:)])
			[[self delegate] performSelector:@selector(performClickForView:)
								  withObject:self];

		/*
		 * Call performClick on column
		 */

//		NSTableColumn *checkboxColumn = [self tableColumnWithIdentifier:@"Check"];
//		NSButtonCell *buttonCell = (NSButtonCell *)[checkboxColumn dataCellForRow:[self selectedRow]];
//		[buttonCell performClick:self];
//		[super keyDown:event];
	}
	else {
		[super keyDown:event];
	}
}

@end
