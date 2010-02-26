//
//  LinkArrowCell.m
//  LinkArrows
//
//  Copyright 2010 bdunagan.com. All rights reserved.
//

#import "LinkArrowCell.h"

#define kLinkArrowWidth 12
#define kLinkArrowWidthPadding 6

@implementation LinkArrowCell

+ (NSRect)linkRect:(NSRect)aRect {
	return NSMakeRect(aRect.origin.x + aRect.size.width - kLinkArrowWidth, aRect.origin.y - 1, kLinkArrowWidth, aRect.size.height);
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		// Set up link arrow.
		isLinkVisible = NO;
		linkArrow = [[NSButtonCell alloc] init];
		[linkArrow setButtonType:NSSwitchButton];
		[linkArrow setBezelStyle:NSSmallSquareBezelStyle];
		[linkArrow setImagePosition:NSImageRight];
		[linkArrow setTitle:@""];
		[linkArrow setBordered:NO];
		[linkArrow setImage:[NSImage imageNamed:@"link_arrow"]];
		[linkArrow setAlternateImage:[NSImage imageNamed:@"link_arrow_click"]];
	}
	return self;
}

- (void)dealloc {
	[linkArrow release];
	linkArrow = nil;
	[super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[super encodeWithCoder:coder];
}

- (id)copyWithZone:(NSZone *)zone {
	LinkArrowCell *copy = [super copyWithZone:zone];
	if (linkArrow) copy->linkArrow = [linkArrow copyWithZone:zone];
	return copy;
}

- (void)setLinkVisible:(BOOL)newValue {
	isLinkVisible = newValue;
}

- (BOOL)shouldDisplayLink {
	return isLinkVisible;
}

- (void)drawInteriorWithFrame:(NSRect)aRect inView:(NSView *)controlView {
	NSRect textRect = NSMakeRect(aRect.origin.x, aRect.origin.y, aRect.size.width - kLinkArrowWidth - kLinkArrowWidthPadding, aRect.size.height);

	// Draw text.
	[super drawInteriorWithFrame:textRect inView:controlView];

	// Draw link arrow.
	if ([self shouldDisplayLink]) {
		if (![self isHighlighted]) {
			// The cell is not highlighted.
			[linkArrow setImage:[NSImage imageNamed:@"link_arrow"]];
			[linkArrow setAlternateImage:[NSImage imageNamed:@"link_arrow_click"]];
		}
		else if ([[[self controlView] window] isKeyWindow] && [[[self controlView] window] firstResponder] == [self controlView]) {
			// The cell is highlighted, and the window is key.
			[linkArrow setImage:[NSImage imageNamed:@"link_arrow_highlight"]];
			[linkArrow setAlternateImage:[NSImage imageNamed:@"link_arrow_click_highlight"]];
		}
		else {
			// The cell is highlighted, but the window is not key.
			[linkArrow setImage:[NSImage imageNamed:@"link_arrow_click"]];
			[linkArrow setAlternateImage:[NSImage imageNamed:@"link_arrow"]];
		}

		[linkArrow drawInteriorWithFrame:[LinkArrowCell linkRect:aRect] inView:controlView];
	}
}

- (NSUInteger)hitTestForEvent:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)controlView {
	// Figure out hit point in view.
	NSRect linkRect = [LinkArrowCell linkRect:cellFrame];
	NSPoint p = [[[NSApp  mainWindow] contentView] convertPoint:[event locationInWindow] toView:controlView];
	if (p.x > linkRect.origin.x && p.x < (linkRect.origin.x + linkRect.size.width) && 
		p.y > linkRect.origin.y && p.y < (linkRect.origin.y + linkRect.size.height)) {
		// Point inside link arrow.
		[linkArrow setState:NSOnState];
		return NSCellHitContentArea | NSCellHitTrackableArea;
	}
	else {
		// Point outside link arrow.
		[linkArrow setState:NSOffState];
		return [super hitTestForEvent:event inRect:cellFrame ofView:controlView];
	}
}

- (BOOL)trackMouse:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)untilMouseUp {
	// Check if link arrow was hit.
	int hitType = [self hitTestForEvent:[NSApp currentEvent] inRect:cellFrame ofView:controlView];
	BOOL isButtonClicked = hitType == (NSCellHitContentArea | NSCellHitTrackableArea);
	if (!isButtonClicked) return YES;

	// Ignore events other than mouse down.
	if ([event type] != NSLeftMouseDown) return YES;

	// Grab all events until a mouse up event.
	while ([event type] != NSLeftMouseUp) {
		// Check if link arrow was hit.
		hitType = [self hitTestForEvent:[NSApp currentEvent] inRect:cellFrame ofView:controlView];
		isButtonClicked = hitType == (NSCellHitContentArea | NSCellHitTrackableArea);
		// Update the cell's display.
		[controlView setNeedsDisplayInRect:cellFrame];
		// Pass event if not hit.
		if (!isButtonClicked) {
			[NSApp sendEvent:event];
		}
		// Grab next event.
		event = [[controlView window] nextEventMatchingMask:(NSLeftMouseUpMask | NSLeftMouseDraggedMask | NSMouseEnteredMask | NSMouseExitedMask)];
	}

	// Perform click only if link arrow was hit.
	if (isButtonClicked) {
		[self performClick:nil];
	}

	return YES;
}

@end
