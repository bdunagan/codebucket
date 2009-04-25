//
//  BDObject.m
//  NSTableView_setObjectValue
//
//  Created by Brian Dunagan on 4/24/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "BDObject.h"

@implementation BDObject

- (id)init {
	self = [super init];
	if (self != nil) {
		isChecked = NO;
	}
	return self;
}

- (BOOL)isChecked {
	return isChecked;
}

- (void)setIsChecked:(BOOL)newValue {
	isChecked = newValue;

	// Update dependent property.
	[self setStatus:nil];
}

- (NSString *)status {
	return isChecked ? @"Checked" : @"Unchecked";
}

- (void)setStatus:(id)value {}

@end
