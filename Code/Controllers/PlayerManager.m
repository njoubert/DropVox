//
//  PlayerManager.m
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayerManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioPlayer.h>


@implementation PlayerManager

- (PlayerManager*) init {
	self = [super init];
	if (self) {
		_state = psPaused;		
		_callbacks = [[NSMutableArray alloc] init];
	}
	return self;
}


- (void)registerPlayerStateCallback:(id <PlayerStateCallbackProtocol>)callthis {
	[_callbacks addObject:[callthis retain]];
}

- (void)notifyCallbacks {
	NSEnumerator * e = [_callbacks objectEnumerator];
	id <PlayerStateCallbackProtocol> callback;
	while (callback = [e nextObject]) {
		[callback playerStateChanged:_state];
	}

}

- (void)pb_togglePlayPause {
	NSLog(@"pb_togglePlayPause");
	if (_state != psPlaying) {
		_state = psPlaying;
	} else {
		_state = psPaused;
	}
	[self notifyCallbacks];
}
- (void)pb_next {
	NSLog(@"pb_next");
}
- (void)pb_prev {
	NSLog(@"pb_prev");
}

- (void)dealloc {
	[_callbacks release];
	[super dealloc];
}

@end
