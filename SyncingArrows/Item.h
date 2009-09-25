//
//  Item.h
//  SyncingArrows
//
//  Created by Brian Dunagan on 9/17/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Item : NSObject {
	NSImage *icon;
	NSString *title;
	NSTimer *stateTimer;
	NSArray *icons;
	int statusState;
}

@property(retain, readwrite) NSImage *icon;
@property(retain, readwrite) NSString *title;

- (id) initWithInterval:(NSTimeInterval)interval;
- (void)updateStatus;

@end
