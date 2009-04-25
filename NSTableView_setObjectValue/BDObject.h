//
//  BDObject.h
//  NSTableView_setObjectValue
//
//  Created by Brian Dunagan on 4/24/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BDObject : NSObject {
	BOOL isChecked;
}

- (id)init;
- (BOOL)isChecked;
- (void)setIsChecked:(BOOL)newValue;
- (NSString *)status;
- (void)setStatus:(id)value;

@end
