//
//  DropVoxAppDelegate.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayViewController;
@class PlayerManager;

@interface DropVoxAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PlayViewController *playViewController;
	PlayerManager *playerManager;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) PlayViewController *playViewController;

@end

