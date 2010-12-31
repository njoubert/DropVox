//
//  MediaManager.m
//  DropVox
//
//  Created by Niels Joubert on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MediaManager.h"
#import "MediaBrowserViewController.h"

@implementation MediaManager
@synthesize currentDir;

-(NSArray *)currentDirMedia {
	NSLog(@"MediaManager currentDirMedia");
	
}
-(NSInteger)currentMediaInDir {
	NSLog(@"MediaManager currentMediaInDir");
}

- (void)presentBrowserFromController:(UIViewController*)controller {
	MediaBrowserViewController* browserController = 
	[[[MediaBrowserViewController alloc] init] autorelease];
	
    UINavigationController* navController = 
	[[[UINavigationController alloc] initWithRootViewController:browserController] autorelease];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [controller presentModalViewController:navController animated:YES];
}

@end
