//
//  BDController.m
//  ProgressInNSTableView
//
//  Created by Brian Dunagan on 12/6/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import "BDController.h"
#import "BDObject.h"
#import "BDContinuousProgressCell.h"
#import "BDDiscreteProgressCell.h"

@implementation BDController

- (id) init
{
	self = [super init];
	if (self != nil)
	{
		objects = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)awakeFromNib
{
	[self addRow:nil];
	
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateList) userInfo:nil repeats:YES];
}

- (void)updateList
{
	[list reloadData];
}

- (IBAction)addRow:(id)sender
{
	BDObject *obj = [[[BDObject alloc] init] autorelease];
	[objects addObject:obj];
	[list reloadData];
}

- (IBAction)removeRow:(id)sender
{
	[objects removeObjectAtIndex:[list selectedRow]];
	[list reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [objects count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	BDObject *obj = [objects objectAtIndex:rowIndex];
	return [NSString stringWithFormat:@"%d", [obj currentStep]];
}

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	BDObject *obj = [objects objectAtIndex:rowIndex];
	if ([aCell isKindOfClass:[BDDiscreteProgressCell class]])
	{
		[aCell setProgress:[obj discreteProgress]];
		[aTableView addSubview:[obj discreteProgress]];
	}
	if ([aCell isKindOfClass:[BDContinuousProgressCell class]])
	{
		[aCell setProgress:[obj continuousProgress]];
		[aTableView addSubview:[obj continuousProgress]];
	}
}

@end
