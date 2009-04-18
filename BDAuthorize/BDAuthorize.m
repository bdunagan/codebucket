//
//  BDAuthorize.m
//  BDAuthorize
//
//  Created by Brian Dunagan on 11/23/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import "BDAuthorize.h"

@implementation BDAuthorize

- (void)awakeFromNib
{
	helperToolPath = [[[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/AuthHelperTool"] retain];
}

- (IBAction)clickCreateFile:(id)sender
{
	NSArray *args = [NSArray arrayWithObjects:helperToolPath, @"create", nil];
	[NSTask launchedTaskWithLaunchPath:helperToolPath arguments:args];
}

- (IBAction)clickDuplicateFile:(id)sender
{
	NSArray *args = [NSArray arrayWithObjects:helperToolPath, @"duplicate", nil];
	[NSTask launchedTaskWithLaunchPath:helperToolPath arguments:args];
}

@end
