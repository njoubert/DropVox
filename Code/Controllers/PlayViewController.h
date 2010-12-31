//
//  DropVoxViewController.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropboxSDK.h"
#import "PlayerStateCallbackProtocol.h"

@class PlayView;
@class PlayerManager;
@class UIPlayPauseButton;
@class MediaManager;

@interface PlayViewController : UIViewController <DBLoginControllerDelegate, PlayerStateCallbackProtocol> {
	
	UIView* _playView;
	UIView* _controlsView;
	UIPlayPauseButton* _playPauseButton;
	UIButton* _nextButton;
	UIButton* _prevButton;
	UILabel* _trackCount;
	UILabel* _trackTime;
	UIButton* _browserButton;
	
	
	PlayerManager* _playerManager;
	MediaManager* _mediaManager;
}
-(PlayViewController*) initWithPlayerManager:(PlayerManager*)pm andMediaManager:(MediaManager*)mm;
-(void)updateUI;

@end

