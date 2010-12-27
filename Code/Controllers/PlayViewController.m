//
//  DropVoxViewController.m
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "PlayerManager.h"
#import "PlayerManager.h"
#import "PlayViewController.h"
#import "PlayView.h"


@implementation PlayViewController

@synthesize playerManager;

#pragma mark -
#pragma mark Initialization

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	printf("PlayViewController.loadView called\n");
	_playView = [[PlayView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] andController:self];
	self.view = _playView;
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	printf("PlayViewController.viewDidLoad called\n");
    [super viewDidLoad];
}


#pragma mark -
#pragma mark Click Handling


-(void)playPauseButtonClicked:(id)sender {
	[playerManager pb_togglePlayPause:_playView];
}
-(void)prevButtonClicked:(id)sender {
	[playerManager pb_prev];
}
-(void)nextButtonClicked:(id)sender {
	[playerManager pb_next];
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

- (void)dealloc {
	[playerManager release];
	[_playView release];
    [super dealloc];
}

@end
