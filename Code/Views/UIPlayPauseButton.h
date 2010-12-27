//
//  UIPlayPauseButton.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. ll rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerStateCallbackProtocol.h"

@interface UIPlayPauseButton : UIButton <PlayerStateCallbackProtocol> {
	UIImage* _btn_play;
	UIImage* _btn_play_pressed;
	UIImage* _btn_pause;
	UIImage* _btn_pause_pressed;
	PlayerState _state;
}


- (id)initWithFrame:(CGRect)frame playButton:(UIImage*) btn_play playButtonPressed:(UIImage*) btn_play_pressed pauseButton:(UIImage*) btn_pause pauseButtonPressed:(UIImage*) btn_pausePressed;
- (void)playerStateChanged:(PlayerState)newState;
- (PlayerState)getState;
@end
