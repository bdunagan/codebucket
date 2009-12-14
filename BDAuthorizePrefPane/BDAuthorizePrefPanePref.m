//
//  BDAuthorizePrefPanePref.m
//  BDAuthorizePrefPane
//
//  Created by Brian Dunagan on 12/13/09.
//  Copyright (c) 2009 bdunagan.com. All rights reserved.
//

#import "BDAuthorizePrefPanePref.h"

@implementation BDAuthorizePrefPanePref

- (void) mainViewDidLoad {
	// Setup security.
	AuthorizationItem items = {kAuthorizationRightExecute, 0, NULL, 0};
	AuthorizationRights rights = {1, &items};
	[authView setAuthorizationRights:&rights];
	authView.delegate = self;
	[authView updateStatus:nil];
	
	[touchButton setEnabled:[self isUnlocked]];
}

- (BOOL)isUnlocked {
	return [authView authorizationState] == SFAuthorizationViewUnlockedState;
}

- (IBAction)clickTouch:(id)sender {
	// Collect arguments into an array.
	NSMutableArray *args = [NSMutableArray array];
	[args addObject:@"-c"];
	[args addObject:@" touch /var/log/test.txt"];
	
	// Convert array into void-* array.
	const char **argv = (const char **)malloc(sizeof(char *) * [args count] + 1);
	int argvIndex = 0;
	for (NSString *string in args) {
		argv[argvIndex] = [string UTF8String];
		argvIndex++;
	}
	argv[argvIndex] = nil;
	
	OSErr processError = AuthorizationExecuteWithPrivileges([[authView authorization] authorizationRef], [@"/bin/sh" UTF8String],
															kAuthorizationFlagDefaults, (char *const *)argv, nil);
	free(argv);
	
	if (processError != errAuthorizationSuccess)
		NSLog(@"Error: %d", processError);
}

//
// SFAuthorization delegates
//

- (void)authorizationViewDidAuthorize:(SFAuthorizationView *)view {
	[touchButton setEnabled:[self isUnlocked]];
}

- (void)authorizationViewDidDeauthorize:(SFAuthorizationView *)view {
	[touchButton setEnabled:[self isUnlocked]];
}

@end
