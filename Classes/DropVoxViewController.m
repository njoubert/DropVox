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
	_playView = [[PlayView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.view = _playView;
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	printf("DropBoxViewController.viewDidLoad called\n");
    [super viewDidLoad];
}


#pragma mark -
#pragma mark Click Handling


-(void)playPauseButtonClicked:(id)sender {
	[[PlayerManager sharedPlayerManager] pb_togglePlayPause:_playView];
}
-(void)prevButtonClicked:(id)sender {
	[[PlayerManager sharedPlayerManager] pb_prev];
}
-(void)nextButtonClicked:(id)sender {
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
	NSLog(@"DVViewController didunload\n");
	_playView = nil;
}


- (void)dealloc {
	NSLog(@"DVViewController dealloc\n");
	[_playView release];
    [super dealloc];
}

@end
