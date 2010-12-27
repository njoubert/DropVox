//
//  PlayView.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlayPauseButton.h"
#import "UIPlayPauseStateCallback.h"

@interface PlayView : UIView <UIPlayPauseStateCallback> {
	UILabel* label;
	UIPlayPauseButton* playPauseButton;
	UIButton* nextButton;
	UIButton* prevButton;
	
}

@end
