//
//  RootViewController.m
//  Using_UITabBarController
//
//  Created by Brian Dunagan on 12/21/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize tabBarController;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Tabs App";
}

- (UITabBarController *)tabBarController {
	if (tabBarController == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"TabBar" owner:self options:nil];
	}

	return tabBarController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
	[tabBarController release];
	tabBarController = nil;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.text = [NSString stringWithFormat:@"Tab %d", indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITabBarController *controller = self.tabBarController;
	[self.navigationController pushViewController:controller animated:YES];
}

- (void)dealloc {
	[tabBarController release];
	tabBarController = nil;
    [super dealloc];
}

@end
