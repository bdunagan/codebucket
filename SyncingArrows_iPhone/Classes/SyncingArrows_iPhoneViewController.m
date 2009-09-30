//
//  SyncingArrows_iPhoneViewController.m
//  SyncingArrows_iPhone
//
//  Created by Brian Dunagan on 9/27/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

#import "SyncingArrows_iPhoneViewController.h"
#import "BDTableViewCell.h"

@implementation SyncingArrows_iPhoneViewController

@synthesize list;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

//
// TableView delegates
//

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Animations";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Recycle cells for speed.
	static NSString *MyIdentifier = @"BDTableViewCell";
	BDTableViewCell *cell = (BDTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		// Create a temporary UIViewController to instantiate the custom cell.
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"BDTableViewCell" bundle:nil];
		// Grab a pointer to the custom cell.
        cell = (BDTableViewCell *)temporaryController.view;
		// Release the temporary UIViewController.
        [temporaryController release];
	}

	// Set the cell's animation mode and interval.
	int rowNum = [indexPath row] + 2;
	[cell setAnimationMode:((rowNum % 2) == 0) withInterval:((rowNum - (rowNum % 2)) / 20.0)];
	return cell;
}

@end
