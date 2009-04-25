//
//  MainController.m
//  NSTableView_setObjectValue
//
//  Created by Brian Dunagan on 4/24/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "MainController.h"
#import "BDObject.h"

@implementation MainController

- (void)awakeFromNib {
	BDObject *object;
	
	object = [[BDObject alloc] init];
	[objects addObject:object];
	[object release];
	
	object = [[BDObject alloc] init];
	[objects addObject:object];
	[object release];
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	if (aTableView == list) {
		// Update dependent instances.
		BOOL newValue = [[[objects arrangedObjects] objectAtIndex:rowIndex] isChecked];
		for (BDObject *object in [objects arrangedObjects]) {
			[object setIsChecked:newValue];
		}
	}
}

@end
