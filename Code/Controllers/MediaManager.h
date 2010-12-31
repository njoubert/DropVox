//
//  MediaManager.h
//  DropVox
//
//  Created by Niels Joubert on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MediaManager : NSObject {
	NSString* currentDir;
}

@property (copy, nonatomic) NSString* currentDir;

-(NSArray *)currentDirMedia;
-(NSInteger)currentMediaInDir;
- (void)presentBrowserFromController:(UIViewController*)controller;

@end
