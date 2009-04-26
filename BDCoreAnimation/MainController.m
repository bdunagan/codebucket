//
//  MainController.m
//  BDCoreAnimation
//
//  Created by Brian Dunagan on 4/25/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "MainController.h"

@implementation MainController

- (void)awakeFromNib {
	NSTreeNode *folderNode;
	folderNode = [NSTreeNode treeNodeWithRepresentedObject:@"Folder 1"];
	[sourceListTree addObject:folderNode];
	[[folderNode mutableChildNodes] addObject:[NSTreeNode treeNodeWithRepresentedObject:@"Item 1"]];
	[[folderNode mutableChildNodes] addObject:[NSTreeNode treeNodeWithRepresentedObject:@"Item 2"]];
	[[folderNode mutableChildNodes] addObject:[NSTreeNode treeNodeWithRepresentedObject:@"Item 3"]];
	folderNode = [NSTreeNode treeNodeWithRepresentedObject:@"Folder 2"];
	[sourceListTree addObject:folderNode];
	[[folderNode mutableChildNodes] addObject:[NSTreeNode treeNodeWithRepresentedObject:@"Item 1"]];
}

- (IBAction)animateButton:(id)sender {
	if (animatedIconView != nil && ![animatedIconView isHidden]) return;
	
	// Get the relevant frames.
	NSView *enclosingView = [[[NSApplication sharedApplication] mainWindow] contentView];
	int rowIndex = [sourceList selectedRow];
	NSRect cellFrame = [sourceList frameOfCellAtColumn:0 row:rowIndex];
	NSRect buttonFrame = [button frame];
	NSRect mainViewFrame = [enclosingView frame];
	
	/*
	 * Icon animation
	 */

	// Determine the animation's path.
	NSPoint startPoint = NSMakePoint(buttonFrame.origin.x + buttonFrame.size.width / 4, buttonFrame.origin.y + buttonFrame.size.height / 4);
	NSPoint curvePoint1 = NSMakePoint(startPoint.x, startPoint.y + 100);
	NSPoint endPoint = NSMakePoint(cellFrame.origin.x, mainViewFrame.size.height - cellFrame.origin.y - cellFrame.size.height);
	NSPoint curvePoint2 = NSMakePoint(endPoint.x + 200, endPoint.y);

	// Create the animation's path.
	CGPathRef path = NULL;
	CGMutablePathRef mutablepath = CGPathCreateMutable();
	CGPathMoveToPoint(mutablepath, NULL, startPoint.x, startPoint.y);
	CGPathAddCurveToPoint(mutablepath, NULL, curvePoint1.x, curvePoint1.y,
						  curvePoint2.x, curvePoint2.y,
						  endPoint.x, endPoint.y);
	path = CGPathCreateCopy(mutablepath);
	CGPathRelease(mutablepath);

	// Create animated icon view.
	NSImage *icon = [button image];
	[animatedIconView release];
	animatedIconView = [[NSImageView alloc] init];
	[animatedIconView setImage:icon];
	[animatedIconView setFrame:NSMakeRect(startPoint.x, startPoint.y, 20, 20)];
	[animatedIconView setHidden:NO];
	[enclosingView addSubview:animatedIconView];

	// Create icon animation.
	CAKeyframeAnimation *animatedIconAnimation = [CAKeyframeAnimation animationWithKeyPath: @"frameOrigin"];
	animatedIconAnimation.duration = 1.0;
	animatedIconAnimation.delegate = self;
	animatedIconAnimation.path = path;
	animatedIconAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	[animatedIconView setAnimations:[NSDictionary dictionaryWithObject:animatedIconAnimation forKey:@"frameOrigin"]];

	// Start the icon animation.
	[[animatedIconView animator] setFrameOrigin:endPoint];

	/*
	 * Yellow fade animation
	 */

	// Create the yellow fade layer.
	CALayer *layer = [CALayer layer];
	[layer setDelegate:self];
	yellowFadeView = [[NSView alloc] init];
	[yellowFadeView setWantsLayer:YES];
	[yellowFadeView setFrame:cellFrame];
	[yellowFadeView setLayer:layer];
	[[yellowFadeView layer] setNeedsDisplay];
	[yellowFadeView setAlphaValue:0.0];
	[sourceList addSubview:yellowFadeView];

	// Create the animation pieces.
	CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath: @"alphaValue"];
	alphaAnimation.beginTime = 1.0;
	alphaAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
	alphaAnimation.toValue = [NSNumber numberWithFloat: 1.0];
	alphaAnimation.duration = 0.25;
	CABasicAnimation *alphaAnimation2 = [CABasicAnimation animationWithKeyPath: @"alphaValue"];
	alphaAnimation2.beginTime = 1.25;
	alphaAnimation2.duration = 0.25;
	alphaAnimation2.fromValue = [NSNumber numberWithFloat: 1.0];
	alphaAnimation2.toValue = [NSNumber numberWithFloat: 0.0];
	CABasicAnimation *alphaAnimation3 = [CABasicAnimation animationWithKeyPath: @"alphaValue"];
	alphaAnimation3.beginTime = 1.5;
	alphaAnimation3.duration = 0.25;
	alphaAnimation3.fromValue = [NSNumber numberWithFloat: 0.0];
	alphaAnimation3.toValue = [NSNumber numberWithFloat: 1.0];
	CABasicAnimation *alphaAnimation4 = [CABasicAnimation animationWithKeyPath: @"alphaValue"];
	alphaAnimation4.beginTime = 1.75;
	alphaAnimation4.duration = 0.25;
	alphaAnimation4.fromValue = [NSNumber numberWithFloat: 1.0];
	alphaAnimation4.toValue = [NSNumber numberWithFloat: 0.0];

	// Create the animation group.
	CAAnimationGroup *yellowFadeAnimation = [CAAnimationGroup animation];
	yellowFadeAnimation.delegate = self;
	yellowFadeAnimation.animations = [NSArray arrayWithObjects: 
									   alphaAnimation, alphaAnimation2, alphaAnimation3, alphaAnimation4, nil];
	yellowFadeAnimation.duration = 2.0;
	[yellowFadeView setAnimations:[NSDictionary dictionaryWithObject:yellowFadeAnimation forKey:@"frameOrigin"]];

	// Start the yellow fade animation.
	[[yellowFadeView animator] setFrame:[yellowFadeView frame]];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
	// Bezier path radius
	int radius = 4;

	// Setup graphics context.
	NSGraphicsContext *nsGraphicsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:NO];
	[NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext:nsGraphicsContext];

	// Convert to NSRect.
	CGRect aRect = [layer frame];
	NSRect rect = NSMakeRect(aRect.origin.x, aRect.origin.y, aRect.size.width, aRect.size.height);

	// Draw dark outside line.
	[NSBezierPath setDefaultLineWidth:2];
	NSBezierPath *highlightPath = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:radius yRadius:radius];
	[[NSColor yellowColor] set];
	[highlightPath stroke];

	// Draw transparent inside fill.
	CGFloat r, g, b, a;
	[[NSColor yellowColor] getRed:&r green:&g blue:&b alpha:&a];
	NSColor *transparentYellow = [NSColor colorWithCalibratedRed:r green:g blue:b alpha:0.5];
	NSBezierPath *fillPath = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:radius yRadius:radius];
	[transparentYellow set];
	[fillPath fill];

	// Finish with graphics context.
	[NSGraphicsContext restoreGraphicsState];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	// Check which animation it is.
	if ([theAnimation isKindOfClass:[CAKeyframeAnimation class]]) {
		// Icon
		[animatedIconView setHidden:YES];
	}
	else if ([theAnimation isKindOfClass:[CAAnimationGroup class]]) {
		// Yellow fade
		[yellowFadeView setHidden:YES];
	}
}

@end
