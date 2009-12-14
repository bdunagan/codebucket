//
//  BDAuthorizePrefPanePref.h
//  BDAuthorizePrefPane
//
//  Created by Brian Dunagan on 12/13/09.
//  Copyright (c) 2009 bdunagan.com. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>
#import <SecurityInterface/SFAuthorizationView.h>

@interface BDAuthorizePrefPanePref : NSPreferencePane  {
	IBOutlet SFAuthorizationView *authView;
	IBOutlet NSButton *touchButton;
}

- (BOOL)isUnlocked;
- (IBAction)clickTouch:(id)sender;

@end
