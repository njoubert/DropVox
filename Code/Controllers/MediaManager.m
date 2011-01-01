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

-(MediaManager*)init {
	self = [super init];
	if (self) {
		_root = [[DropboxDirNode alloc] init];
		_root.name = @"";
	}
	return self;	
}

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
	[[[MediaBrowserViewController alloc] initWithDropboxDir:_root] autorelease];
	
//    UINavigationController* navController = 
//	[[[UINavigationController alloc] initWithRootViewController:browserController] autorelease];
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        navController.modalPresentationStyle = UIModalPresentationFormSheet;
//    }
    [controller presentModalViewController:browserController animated:YES];
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
	NSLog(@"You loaded some metadata at path: %@\n", metadata.path);
	NSLog(@"Contents of metadata is of size: %d\n", [metadata.contents count]);
	
	NSArray* pathPieces = [metadata.path componentsSeparatedByString:@"/"];
		
	//first we find the insertion point
	int index = 0;
	DropboxDirNode* prev = nil;
	DropboxDirNode* cur = _root;
	DropboxFileNode* f = nil;
	while (cur != nil && [cur.name isEqualToString:[pathPieces objectAtIndex:index]] && index < ([pathPieces count]-1)) {
		NSLog(@"Going down one level. Index:{%d}, Path:{%@}", index, [pathPieces objectAtIndex:index]);
		index += 1;
		prev = cur;
		cur = nil;
		if (!metadata.isDirectory && index == [pathPieces count]) {
			NSEnumerator* e = [cur.fileChildren objectEnumerator];
			DropboxFileNode* file;
			while (file = (DropboxFileNode*) [e nextObject]) {
				if (file.name = [pathPieces objectAtIndex:index]) {
					f = file;
				}
			}
		} else {
			NSEnumerator* e = [cur.dirChildren objectEnumerator];
			DropboxDirNode* subdir;
			while (subdir = (DropboxDirNode*) [e nextObject]) {
				if (subdir.name = [pathPieces objectAtIndex:index]) {
					cur = subdir;
				}
			}
		}
	}
	//create further down as necessaey
	BOOL found = (!metadata.isDirectory && f != nil) || (metadata.isDirectory && [cur.name isEqualToString:[pathPieces objectAtIndex:[pathPieces count]-1]]);
	NSLog(@"Traversed as far as we can. Did we find it? %d\n", found);
	if (!found) {
		while (index < [pathPieces count]-2) {
			DropboxDirNode* newdir = [[DropboxDirNode alloc] init];
			newdir.name = [pathPieces objectAtIndex:index];
			NSLog(@"Creating directory name:{%@}", newdir.name);
			newdir.parent = prev;
			[prev.dirChildren addObject:newdir];
			prev = newdir;
			index += 1;
		}
		if (metadata.isDirectory) {
			DropboxDirNode* newdir = [[DropboxDirNode alloc] init];
			newdir.name = [pathPieces objectAtIndex:index];
			NSLog(@"Creating final directory name:{%@}", newdir.name);
			newdir.parent = prev;
			[prev.dirChildren addObject:newdir];
			cur = newdir;
		} else {
			prev = cur.parent;
			f = [[DropboxFileNode alloc] initWithParent:cur];
			f.name = [pathPieces objectAtIndex:index];
			NSLog(@"Creating file named:{%@}", f.name);
			[cur.fileChildren addObject:f];
		}
	}
	
	NSLog(@"Current directory:{%@}\n", cur.name);
	NSLog(@"We have found and/or created the directory structure up to the current directory and file.\n");
	
	//if directory, insert its children
	if (metadata.isDirectory) {
		DBMetadata* o;	
		NSEnumerator* e = [metadata.contents objectEnumerator];
		while (o = (DBMetadata*) [e nextObject]) {
			NSArray* subPathPieces = [o.path componentsSeparatedByString:@"/"];
			NSString* n = [subPathPieces objectAtIndex:[subPathPieces count]-1];
			if (o.isDirectory) {
				NSLog(@"Inserting directory %@", [o path]);
				DropboxDirNode* newdir = [[DropboxDirNode alloc] init];
				newdir.name = n;
				newdir.parent = cur;
				[cur.dirChildren addObject:newdir];
			} else {
				NSLog(@"Inserting file %@", [o path]);
				DropboxFileNode* newf = [[DropboxFileNode alloc] initWithParent:cur];
				newf.name = n;
				newf.parent = cur;
				[cur.fileChildren addObject:newf];
			}
		}
		
	}
	
	NSLog(@"Printing structure");
	[_root printMe:0];
	
}
- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
	NSLog(@"Metadata load failed: %@\n", [error localizedDescription]);
}

@end
