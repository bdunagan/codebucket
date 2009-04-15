//
//  MainController.h
//  Two_NSButtonsCells_in_NSTableView
//
//  Created by Brian Dunagan on 4/14/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainController : NSObject {
	IBOutlet NSArrayController *objects;
}

- (void)performClickForView:(id)sender;

@end
