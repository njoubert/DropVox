//
//  PlayerManager.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioPlayer.h>


#import "PlayPauseStateCallbackProtocol.h"

@interface PlayerManager : NSObject {
	bool _playing;
}
//+ (PlayerManager *)sharedPlayerManager;

- (void)pb_togglePlayPause:(id <PlayPauseStateCallbackProtocol>)callthis;
- (void)pb_next;
- (void)pb_prev;

@end
