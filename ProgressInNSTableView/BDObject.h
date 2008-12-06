//
//  BDObject.h
//  ProgressInNSTableView
//
//  Created by Brian Dunagan on 12/6/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BDObject : NSObject
{
	NSProgressIndicator *continuousProgress;
	NSProgressIndicator *discreteProgress;
	int currentStep;
}

@property (assign) int currentStep;
@property (readwrite, retain) NSProgressIndicator *continuousProgress;
@property (readwrite, retain) NSProgressIndicator *discreteProgress;

- (void)incrementStep;

@end
