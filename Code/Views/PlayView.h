//
//  PlayView.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayPauseStateCallbackProtocol.h"

@class PlayViewController;
@class UIPlayPauseButton;

@interface PlayView : UIView <PlayPauseStateCallbackProtocol> {
	UILabel* label;
	UIPlayPauseButton* playPauseButton;
	UIButton* nextButton;
	UIButton* prevButton;
	
}
- (id)initWithFrame:(CGRect)frame andController:(PlayViewController*)pvController;
@end
