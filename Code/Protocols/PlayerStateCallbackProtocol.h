//
//  UIPlayPauseStateCallback.h
//  DropVox
//
//  Created by Niels Joubert on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalTypes.h"

@protocol PlayerStateCallbackProtocol
-(void) playerStateChanged:(PlayerState)newState;
@end
