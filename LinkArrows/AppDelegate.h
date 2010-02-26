//
//  AppDelegate.h
//  LinkArrows
//
//  Copyright 2010 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject {
    NSWindow *window;
	NSTableView *tableView; 
	NSMutableArray *objects;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView *tableView;
@property (nonatomic, retain) NSMutableArray *objects;

@end
