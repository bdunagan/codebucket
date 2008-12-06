//
//  BDController.h
//  ProgressInNSTableView
//
//  Created by Brian Dunagan on 12/6/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BDController : NSObject
{
	IBOutlet NSTableView *list;
	NSMutableArray *objects;
}

- (IBAction)addRow:(id)sender;
- (IBAction)removeRow:(id)sender;

@end
