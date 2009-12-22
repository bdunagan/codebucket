//
//  TabController.m
//  Using_UITabBarController
//
//  Created by Brian Dunagan on 12/21/09.
//  Copyright 2009 bdunagan.com. All rights reserved.
//

#import "TabController.h"

@implementation TabController

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
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %d", self.title, indexPath.row];
    return cell;
}

@end
