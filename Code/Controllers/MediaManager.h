//
//  MediaManager.h
//  DropVox
//
//  Created by Niels Joubert on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DropboxSDK.h"

@interface MediaManager : NSObject <DBRestClientDelegate> {
	NSString* currentDir;
	DBRestClient* restClient;
}

@property (copy, nonatomic) NSString* currentDir;
@property (nonatomic, readonly) DBRestClient* restClient;

-(NSArray *)currentDirMedia;
-(NSInteger)currentMediaInDir;
- (void)presentBrowserFromController:(UIViewController*)controller;
- (void)buildTreeStructure;

@end
