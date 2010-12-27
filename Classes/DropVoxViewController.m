//
//  DropVoxViewController.m
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "PlayerManager.h"
#import "DropVoxViewController.h"
#import "PlayView.h"

@implementation DropVoxViewController

#pragma mark -
#pragma mark Initialization

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	printf("DropBoxViewController.loadView called\n");
	UIView *contentView = [[PlayView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.view = contentView;
	[contentView release];
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	printf("DropBoxViewController.viewDidLoad called\n");
    [super viewDidLoad];
}


#pragma mark -
#pragma mark Click Handling


-(void)playPauseButtonClicked:(id)sender {
	NSLog(@"playPause button clicked");
	[[PlayerManager sharedPlayerManager] pb_togglePlayPause:self.view];
//	if ([button isActive]) {
//		[button makeInactive];
//	} else {
//		[button makeActive];
//	}	
}
-(void)prevButtonClicked:(id)sender {
	NSLog(@"prevButtonClicked");
	UIButton *button = (UIButton *)sender;
	[[PlayerManager sharedPlayerManager] pb_prev];
}
-(void)nextButtonClicked:(id)sender {
	NSLog(@"nextButtonClicked");
	UIButton *button = (UIButton *)sender;
	[[PlayerManager sharedPlayerManager] pb_next];
}


#pragma mark -
#pragma mark Built-ins


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
