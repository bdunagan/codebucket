//
//  AuthHelperTool.m
//  BDAuthorize
//
//  Created by Brian Dunagan on 11/23/08.
//  Copyright 2008 bdunagan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"AuthHelperTool started");

	// Look at arguments.
	if (argc == 3)
	{
		// Hasn't been called as root yet.
		NSLog(@"AuthHelperTool executing self-repair");
		
		// Paraphrased from http://developer.apple.com/documentation/Security/Conceptual/authorization_concepts/03authtasks/chapter_3_section_4.html
		OSStatus myStatus;
		AuthorizationFlags myFlags = kAuthorizationFlagDefaults;
		AuthorizationRef myAuthorizationRef;

		myStatus = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment, myFlags, &myAuthorizationRef);
		if (myStatus != errAuthorizationSuccess)
			return myStatus;

		AuthorizationItem myItems = {kAuthorizationRightExecute, 0, NULL, 0};
		AuthorizationRights myRights = {1, &myItems};
		myFlags = kAuthorizationFlagDefaults |
			kAuthorizationFlagInteractionAllowed |
			kAuthorizationFlagPreAuthorize |
			kAuthorizationFlagExtendRights;

		myStatus = AuthorizationCopyRights (myAuthorizationRef, &myRights, NULL, myFlags, NULL );
		if (myStatus != errAuthorizationSuccess)
			return myStatus;

		char *myToolPath = argv[1];
		char *myArguments[] = {argv[1], "--self-repair", argv[2], NULL};
		FILE *myCommunicationsPipe = NULL;
		
		myFlags = kAuthorizationFlagDefaults;
		myStatus = AuthorizationExecuteWithPrivileges(myAuthorizationRef, myToolPath, myFlags, myArguments, &myCommunicationsPipe);
		NSLog(@"AuthHelperTool called AEWP");
	}
	else
	{
		if (argc == 4)
		{
			NSString *command = [NSString stringWithCString:argv[3]];
			NSLog(@"AuthHelperTool sent command %@", command);

			if ([command isEqualToString:@"create"])
			{
				NSLog(@"AuthHelperTool executing %@", command);

				NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
				[dictionary setValue:@"world" forKey:@"hello"];
				BOOL isSuccess = [dictionary writeToFile:@"/Library/LaunchDaemons/com.bdunagan.bdauthorize.plist" atomically:NO];

				NSLog(@"AuthHelperTool done with %@: %d", command, isSuccess);
			}

			if ([command isEqualToString:@"duplicate"])
			{
				NSLog(@"AuthHelperTool executing %@", command);

				// setuid is necessary to execute sudo.
				setuid(0);
				NSArray *args = [NSArray arrayWithObjects: @"cp", @"/Library/LaunchDaemons/com.bdunagan.bdauthorize.plist", @"/Library/LaunchDaemons/com.bdunagan.bdauthorize.plist.duplicate", nil];
				[NSTask launchedTaskWithLaunchPath:@"/usr/bin/sudo" arguments:args];
				NSLog(@"AuthHelperTool done with %@: ?", command);
			}
		}
	}
	NSLog(@"AuthHelperTool exiting");

	[pool release];
	return 0;
}
