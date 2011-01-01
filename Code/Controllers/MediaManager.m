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
	[self.restClient loadMetadata:@"/Unsorted Music"];
	[self.restClient loadMetadata:@"/Unsorted Music/Mixes"];
	
}



- (void)presentBrowserFromController:(UIViewController*)controller {
	MediaBrowserViewController* browserController = 
	[[[MediaBrowserViewController alloc] initWithDropboxDir:_root] autorelease];
	
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
		NSLog(@"Going down one level. Index:{%d}, Path:{%@}, Looking for dir: {%@}", index, [pathPieces objectAtIndex:index], [pathPieces objectAtIndex:index+1]);
		index += 1;
		prev = cur;
		cur = nil;
		if ((!metadata.isDirectory) && index == [pathPieces count]) {
			NSLog(@"LOOKING FOR A FILE");
			NSEnumerator* e = [prev.fileChildren objectEnumerator];
			DropboxFileNode* file;
			while (file = (DropboxFileNode*) [e nextObject]) {
				if ([file.name isEqualToString:[pathPieces objectAtIndex:index]]) {
					f = file;
				}
			}
		} else {
			NSEnumerator* e = [prev.dirChildren objectEnumerator];
			DropboxDirNode* subdir;
			while (subdir = (DropboxDirNode*) [e nextObject]) {
				NSLog(@"=== subdir name is: {%@}\n", subdir.name);
				if ([subdir.name isEqualToString:[pathPieces objectAtIndex:index]]) {
					cur = subdir;
				}
			}
		}
	}
	//create further down as necessaey
	BOOL found = (!metadata.isDirectory && f != nil) || (metadata.isDirectory && [cur.name isEqualToString:[pathPieces objectAtIndex:[pathPieces count]-1]]);
	NSLog(@"Traversed as far as we can. Did we find it? %d, is cur nil? %d\n", found, cur == nil);
	if (!found) {
		while (index < [pathPieces count]-1) {
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
	
	if (metadata.isDirectory) {
		DBMetadata* o;	
		NSEnumerator* e = [metadata.contents objectEnumerator];
		while (o = (DBMetadata*) [e nextObject]) {
			NSArray* subPathPieces = [o.path componentsSeparatedByString:@"/"];
			NSString* n = [subPathPieces objectAtIndex:[subPathPieces count]-1];
			if (o.isDirectory && ![cur containsDirOfName:n]) {
				NSLog(@"Inserting directory %@", [o path]);
				DropboxDirNode* newdir = [[DropboxDirNode alloc] init];
				newdir.name = n;
				newdir.parent = cur;
				[cur.dirChildren addObject:newdir];
			} else if ((!o.isDirectory) && (![cur containsFileOfName:n])) {
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
