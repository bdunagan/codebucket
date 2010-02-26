//
//  LinkArrowCell.h
//  LinkArrows
//
//  Copyright 2010 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LinkArrowCell : NSTextFieldCell {
	NSButtonCell *linkArrow;
	BOOL isLinkVisible;
}

+ (NSRect)linkRect:(NSRect)aRect;
- (BOOL)shouldDisplayLink;
- (void)setLinkVisible:(BOOL)newValue;

@end
