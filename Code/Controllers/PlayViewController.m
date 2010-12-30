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
#import "UIPlayPauseButton.h"

#import "DropboxSDK.h"

@implementation PlayViewController

#pragma mark -
#pragma mark Initialization

- (PlayViewController*) initWithPlayerManager:(PlayerManager*)pm {
	self = [super init];
	if (self) {
		_playerManager = [pm retain];
	}
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	NSLog(@"PlayViewController loadView");

	_playView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	self.view = _playView;
	
	_playView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
	
	float detailedFontHeight = 12.0;
	float controlsTop = 20.0f;
	CGRect playPauseRect =	CGRectMake(120.0f, controlsTop, 80.0f, 80.0f); 
	CGRect prevRect =		CGRectMake(35.0f, controlsTop+10.0f, 60.0f, 60.0f);
	CGRect nextRect =		CGRectMake(225.0f, controlsTop+10.0f, 60.0f, 60.0f);
	CGRect trackCountRect = CGRectMake(35.0f, controlsTop+70.0f, 50.0f, detailedFontHeight);
	CGRect trackTimeRect =  CGRectMake(225.0f, controlsTop+70.0f, 50.0f, detailedFontHeight);
	
	UIImage* btn_play =			[UIImage imageNamed:@"btn_play.png"];
	UIImage* btn_play_pressed = [UIImage imageNamed:@"btn_play_pressed.png"];
	UIImage* btn_pause =		[UIImage imageNamed:@"btn_pause.png"];
	UIImage* btn_pause_pressed = [UIImage imageNamed:@"btn_pause_pressed.png"];		
	
	UIImage* btn_next =		[UIImage imageNamed:@"btn_forward.png"];
	UIImage* btn_next_p = [UIImage imageNamed:@"btn_forward_pressed.png"];		
	
	UIImage* btn_prev =		[UIImage imageNamed:@"btn_back.png"];
	UIImage* btn_prev_p = [UIImage imageNamed:@"btn_back_pressed.png"];		
		
	_playPauseButton = [[UIPlayPauseButton alloc] 
					   initWithFrame:playPauseRect
					   playButton:btn_play 
					   playButtonPressed:btn_play_pressed 
					   pauseButton:btn_pause 
					   pauseButtonPressed:btn_pause_pressed];
	[_playPauseButton addTarget:self
						action:@selector(playPauseButtonClicked:) 
			  forControlEvents:UIControlEventTouchUpInside];
	[_playView addSubview:_playPauseButton];
	
	
	_prevButton = [[UIButton alloc] 
				  initWithFrame:prevRect];		
	[_prevButton setBackgroundImage:btn_prev forState:UIControlStateNormal];
	[_prevButton setBackgroundImage:btn_prev_p forState:UIControlStateHighlighted];
	[_prevButton addTarget:self
				   action:@selector(prevButtonClicked:) 
		 forControlEvents:UIControlEventTouchUpInside];		
	[_playView addSubview:_prevButton];
	
	
	_nextButton = [[UIButton alloc] 
				  initWithFrame:nextRect];
	[_nextButton setBackgroundImage:btn_next forState:UIControlStateNormal];
	[_nextButton setBackgroundImage:btn_next_p forState:UIControlStateHighlighted];		
	[_nextButton addTarget:self
				   action:@selector(nextButtonClicked:) 
		 forControlEvents:UIControlEventTouchUpInside];		
	[_playView addSubview:_nextButton];
	
	
	_trackCount = [[UILabel alloc]
				   initWithFrame:trackCountRect];
	_trackCount.text = @"11/18";
	_trackCount.font = [UIFont systemFontOfSize:detailedFontHeight];
	_trackCount.textColor = [UIColor whiteColor];
	_trackCount.backgroundColor = [UIColor clearColor];
	[_playView addSubview:_trackCount];

	_trackTime = [[UILabel alloc]
				   initWithFrame:trackTimeRect];
	_trackTime.text = @"18:35";
	_trackTime.font = [UIFont systemFontOfSize:detailedFontHeight];
	_trackTime.textColor = [UIColor whiteColor];
	_trackTime.backgroundColor = [UIColor clearColor];
	[_playView addSubview:_trackTime];
	
	
	
	//register callbacks
	[_playerManager registerPlayerStateCallback:self];
	
	[btn_play release];
	[btn_play_pressed release];
	[btn_pause release];
	[btn_pause_pressed release];
	[btn_next release];
	[btn_next_p release];
	[btn_prev release];
	[btn_prev_p release];	
	
}

- (void)releaseViews {
	[_playView release];
	_playView = nil;
	[_playPauseButton release];
	_playPauseButton = nil;
	[_prevButton release];
	_prevButton = nil;
	[_nextButton release];
	_nextButton = nil;
	
}

- (void) viewDidLoad {
	NSLog(@"PlayViewController viewDidLoad\n");
}

- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"PlayViewController viewDidAppear\n");
	[super viewDidAppear:animated];
	if (![[DBSession sharedSession] isLinked]) {
		NSLog(@"Showing DropBox Login\n");
		DBLoginController* controller = [[DBLoginController new] autorelease];
		controller.delegate = self;
		[controller presentFromController:self];		
	}
}

#pragma mark -
#pragma mark Click Handling


-(void)playPauseButtonClicked:(id)sender {
	[_playerManager pb_togglePlayPause];
}
-(void)prevButtonClicked:(id)sender {
	[_playerManager pb_prev];
}
-(void)nextButtonClicked:(id)sender {
	[_playerManager pb_next];
}

#pragma mark -
#pragma mark DBLoginControllerDelegate methods

- (void)loginControllerDidLogin:(DBLoginController*)controller {
    //[self updateButtons];
	//[self.navigationController pushViewController:photoViewController animated:YES];
	NSLog(@"DBLoginController didLogin");
}

- (void)loginControllerDidCancel:(DBLoginController*)controller {
	
}

#pragma mark -
#pragma mark DBLoginControllerDelegate methods

-(void) playerStateChanged:(PlayerState)newState {
	[_playPauseButton playerStateChanged:newState];
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

- (void) viewDidUnload {
	[super viewDidUnload];
	[self releaseViews];
}

- (void)dealloc {
	[self releaseViews];
	[_playerManager release];
    [super dealloc];
}

@end
