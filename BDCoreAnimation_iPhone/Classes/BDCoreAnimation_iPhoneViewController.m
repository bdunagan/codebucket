//
//  BDCoreAnimation_iPhoneViewController.m
//  BDCoreAnimation_iPhone
//
//  Created by Brian Dunagan on 4/26/09.
//  Copyright bdunagan.com 2009. All rights reserved.
//

#import "BDCoreAnimation_iPhoneViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation BDCoreAnimation_iPhoneViewController

- (void)dealloc {
	[icon release];
    [super dealloc];
}

- (void)viewDidLoad {
	// Setup icon.
	icon = [[UIImage imageNamed:@"StarTrek.png"] retain];
	[iconView setImage:icon];

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//
// TableView delegates
//

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 9;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Item List";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Recycle cells for speed.
	static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}

	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.text = [NSString stringWithFormat:@"Item %d", [indexPath row]];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self animateIcon];
}

- (void)animateIcon {
	// Get the relevant frames.
	UIView *enclosingView = mainView;
	CGRect cellFrame = [[list cellForRowAtIndexPath:[list indexPathForSelectedRow]] frame];
	CGRect buttonFrame = [iconView frame];

	/*
	 * Icon animation
	 */

	// Determine the animation's path.
	CGPoint startPoint = CGPointMake(buttonFrame.origin.x + buttonFrame.size.width / 2, buttonFrame.origin.y + buttonFrame.size.height / 2);
	CGPoint curvePoint1 = CGPointMake(startPoint.x + 250, startPoint.y);
	CGPoint endPoint = CGPointMake(cellFrame.origin.x + 20, cellFrame.origin.y + topView.frame.size.height);
	CGPoint curvePoint2 = CGPointMake(endPoint.x + 100, endPoint.y - 100);

	// Create the animation's path.
	CGPathRef path = NULL;
	CGMutablePathRef mutablepath = CGPathCreateMutable();
	CGPathMoveToPoint(mutablepath, NULL, startPoint.x, startPoint.y);
	CGPathAddCurveToPoint(mutablepath, NULL, curvePoint1.x, curvePoint1.y,
						  curvePoint2.x, curvePoint2.y,
						  endPoint.x, endPoint.y);
	path = CGPathCreateCopy(mutablepath);
	CGPathRelease(mutablepath);

	// Create animated icon view.
	[animatedIconView release];
	animatedIconView = [[UIImageView alloc] init];
	[animatedIconView setImage:icon];
	[animatedIconView setFrame: CGRectMake(startPoint.x, startPoint.y, 32, 32)];
	[animatedIconView setHidden:NO];
	[enclosingView addSubview:animatedIconView];
	CALayer *iconViewLayer = animatedIconView.layer;

	CAKeyframeAnimation *animatedIconAnimation = [CAKeyframeAnimation animationWithKeyPath: @"position"];
	animatedIconAnimation.duration = 1.0;
	animatedIconAnimation.delegate = self;
	animatedIconAnimation.path = path;
	animatedIconAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	[iconViewLayer addAnimation:animatedIconAnimation forKey:@"animateIcon"];

	// Start the icon animation.
	[iconViewLayer setPosition:CGPointMake(endPoint.x, endPoint.y)];

	/*
	 * Yellow fade animation
	 */

	// Create the yellow fade layer.
	[yellowFadeView release];
	yellowFadeView = [[UIView alloc] init];
	[yellowFadeView setFrame:cellFrame];
	[yellowFadeView setHidden:NO];
	[yellowFadeView setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5]];
	[yellowFadeView setAlpha:0.0];
	[list addSubview:yellowFadeView];

	// Create the yellow fade animation.
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelay:1.0];
	[UIView setAnimationDuration:.25];
	[UIView setAnimationRepeatAutoreverses:YES];
	[UIView setAnimationRepeatCount:2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[yellowFadeView setAlpha:1.0];
	[UIView commitAnimations];
}

- (void)animationDidStop:(id)animationID finished:(BOOL)flag context:(id)context {
	[yellowFadeView setHidden:YES];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	[animatedIconView setHidden:YES];
}

@end
