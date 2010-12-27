//
//  PlayerManager.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GlobalTypes.h"
#import "PlayerStateCallbackProtocol.h"

@interface PlayerManager : NSObject {
	PlayerState _state;
	NSMutableArray *_callbacks;
}
- (void)registerPlayerStateCallback:(id <PlayerStateCallbackProtocol>)callthis;
- (void)pb_togglePlayPause;
- (void)pb_next;
- (void)pb_prev;

@end
