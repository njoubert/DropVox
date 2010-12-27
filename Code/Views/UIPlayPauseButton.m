//
//  UIPlayPauseButton.m
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIPlayPauseButton.h"


@implementation UIPlayPauseButton


- (id)initWithFrame:(CGRect)frame playButton:(UIImage*) btn_play playButtonPressed:(UIImage*) btn_play_pressed pauseButton:(UIImage*) btn_pause pauseButtonPressed:(UIImage*) btn_pause_pressed  {
    if ((self = [super initWithFrame:frame])) {
		_btn_play = [btn_play retain];
		_btn_play_pressed = [btn_play_pressed retain];
		_btn_pause = [btn_pause retain];
		_btn_pause_pressed = [btn_pause_pressed retain];
		self.showsTouchWhenHighlighted = NO;
		self.adjustsImageWhenDisabled = NO;
		self.adjustsImageWhenHighlighted = NO;	
		[self playerStateChanged:psPaused];
    }
    return self;
}


- (void)playerStateChanged:(PlayerState)newState {
	if (newState == psPaused) {
		
		_state = newState;
		[self setBackgroundImage:_btn_play forState:UIControlStateNormal];
		[self setBackgroundImage:_btn_play_pressed forState:UIControlStateHighlighted];
	
	} else if (newState == psPlaying) {
		
		_state = newState;
		[self setBackgroundImage:_btn_pause forState:UIControlStateNormal];
		[self setBackgroundImage:_btn_pause_pressed forState:UIControlStateHighlighted];
		
	} else if (newState == psBusy) {
	
		_state = newState;
		[self setBackgroundImage:_btn_play forState:UIControlStateNormal];
		[self setBackgroundImage:_btn_play_pressed forState:UIControlStateHighlighted];
	
	}
	
}
- (PlayerState)getState {
	return _state;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc {
	[_btn_play release];
	[_btn_play_pressed release];
	[_btn_pause release];
	[_btn_pause_pressed release];
    [super dealloc];
}



@end
