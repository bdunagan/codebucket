//
//  RootViewController.m
//  UIScrollView_in_UIScrollView
//
//  Created by Brian Dunagan on 12/8/08.
//  Copyright bdunagan.com 2008. All rights reserved.
//

#import "RootViewController.h"
#import "UIScrollView_in_UIScrollViewAppDelegate.h"
#import "BDTableViewCell.h"

@implementation RootViewController

- (void)viewDidLoad {
	self.tableView.scrollEnabled = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section % 2 == 1)
		return @"UITextView";
	else
		return @"UITableViewCell";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int section = [indexPath section];
	if (section % 2 == 1)
		return 100;
	else
		return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *myTextViewId = @"MyTextViewId";
	static NSString *myTableCellId = @"MyTableCellId";
	NSInteger section = [indexPath section];
	
	UITableViewCell *cell = nil;
	if (section % 2 == 1)
	{
		// It's important to reuse the UITextView.
		// cell = [tableView dequeueReusableCellWithIdentifier:myTextViewId];
		if (cell == nil)
		{
			cell = [[[BDTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:myTextViewId] autorelease];

			UITextView *textView = [[[UITextView alloc] initWithFrame:CGRectZero] autorelease];
			textView.text = @"This is a UITextView. These contents don't consistently appear because of a UI issue with a UIScrollView in a UIScrollView. This is a UITextView. These contents don't consistently appear because of a UI issue with a UIScrollView in a UIScrollView.";
			((BDTableViewCell *)cell).textView = textView;

			// Fire an NSTimer in half a second to update the cell's layout. That will make the UITextView appear.
			// [NSTimer scheduledTimerWithTimeInterval:.5 target:cell selector:@selector(setNeedsLayout) userInfo:nil repeats:NO];
		}
	}
	else
	{
		cell = [tableView dequeueReusableCellWithIdentifier:myTableCellId];
		if (cell == nil)
		{
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:myTableCellId] autorelease];
			cell.text = @"Just a normal UITableViewCell";
		}
	}
	
	// Set up the cell
	return cell;
}

- (void)dealloc {
	[super dealloc];
}

@end
