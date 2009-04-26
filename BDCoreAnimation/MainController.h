//
//  MainController.h
//  BDCoreAnimation
//
//  Created by Brian Dunagan on 4/25/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface MainController : NSObject {
	IBOutlet NSOutlineView *sourceList;
	IBOutlet NSTreeController *sourceListTree;
	IBOutlet NSButton *button;

	NSImageView *animatedIconView;
	NSView *yellowFadeView;
}

- (IBAction)animateButton:(id)sender;
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag;

@end
