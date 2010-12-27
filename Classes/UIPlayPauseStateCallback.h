//
//  UIPlayPauseStateCallback.h
//  DropVox
//
//  Created by Niels Joubert on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol UIPlayPauseStateCallback
-(void) setPlaying;
-(void) setPaused;
@end
