//
//  PlayerManager.m
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayerManager.h"


@implementation PlayerManager


- (void)pb_togglePlayPause:(id <UIPlayPauseStateCallback>)callthis {
	NSLog(@"pb_togglePlayPause");
	_playing = !_playing;
	if (_playing) {
		[callthis setPlaying];
	} else {
		[callthis setPaused];		
	}
		
}
- (void)pb_next {
	
}
- (void)pb_prev {
	
}

- (PlayerManager*) init {
	self = [super init];
	if (self) {
		_playing = false;		
		
	}
	return self;
}

#pragma mark -
#pragma mark Singleton Implementation

static PlayerManager *sharedPlayerManager = nil;
+ (PlayerManager *)sharedPlayerManager {
	@synchronized(self) {
		if (sharedPlayerManager == nil) {
			sharedPlayerManager = [[self alloc] init];
		}
	}
	return sharedPlayerManager;
}

+(id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedPlayerManager == nil) {
			sharedPlayerManager = [super allocWithZone:zone];
			return sharedPlayerManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

- (NSUInteger)retainCount {
	return NSUIntegerMax;
}

- (void)release {
}

-(id)autorelease {
	return self;
}

@end
