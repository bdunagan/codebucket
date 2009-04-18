//
//  main.m
//  BDAuthorize
//
//  Created by Brian Dunagan on 11/23/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int value = NSApplicationMain(argc,  (const char **) argv);
	[pool release];
	return value;
}
