//
//  DropVoxViewController.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayView;
@class PlayerManager;

@interface PlayViewController : UIViewController {
	PlayView* _playView;
	PlayerManager* playerManager;
}
@property (retain) PlayerManager* playerManager;
@end

