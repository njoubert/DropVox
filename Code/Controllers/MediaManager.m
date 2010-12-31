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

-(void)buildTreeStructure {
	NSLog(@"building tree structure...\n");
	[self.restClient loadMetadata:@"/"];
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

- (DBRestClient*)restClient {
    if (restClient == nil) {
		NSLog(@"Creating rest client...\n");
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

#pragma mark -
#pragma mark DBRestClientDelegate
- (void)restClientDidLogin:(DBRestClient*)client {
	NSLog(@"restClientDidLogin.\n");
}
- (void)restClient:(DBRestClient*)client loginFailedWithError:(NSError*)error {
	NSLog(@"loginFailedWithError.\n");
}
- (void)restClient:(DBRestClient*)client loadedAccountInfo:(DBAccountInfo*)info {
	NSLog(@"loadedAccountInfo: %@", [info displayName]);
}
- (void)restClient:(DBRestClient*)client loadAccountInfoFailedWithError:(NSError*)error {
	NSLog(@"loadAccountInfoFailedWithError.\n");	
}


- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
	NSLog(@"You loaded some metadata!\n");
	NSLog(@"Contents of metadata is of size: %d\n", [metadata.contents count]);
}
- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
	NSLog(@"Metadata load failed: %@\n", [error localizedDescription]);
}

@end
