//
//  BDDiscreteProgressCell.h
//  ProgressInNSTableView
//
//  Created by Brian Dunagan on 12/6/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BDDiscreteProgressCell : NSTextFieldCell
{
	NSProgressIndicator *progress;
}

@property (readwrite, copy) NSProgressIndicator *progress;

@end
