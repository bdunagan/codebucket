//
//  MainController.m
//  Two_NSButtonsCells_in_NSTableView
//
//  Created by Brian Dunagan on 4/14/09.
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

- (void)performClickForView:(id)sender {
	NSLog(@"clicked");
}

@end
