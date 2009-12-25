//
//  MainController.h
//  MenuBarItem
//
//  Created by Brian Dunagan on 12/23/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainController : NSObject {
	NSStatusItem *statusItem;
	IBOutlet NSMenu *menu;
	IBOutlet NSMenuItem *menuItem;
}

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) NSMenu *menu;
@property (nonatomic, retain) NSMenuItem *menuItem;

- (IBAction)openSystemPreferences:(id)sender;

@end
