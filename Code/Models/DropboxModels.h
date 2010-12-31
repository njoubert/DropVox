//
//  DropboxModels.h
//  DropVox
//
//  Created by Niels Joubert on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DropboxDirNode;
@class DropboxFileNode;

// Directory node can store child directory nodes and file nodes.
@interface DropboxDirNode : NSObject {
	NSMutableArray *dirChildren;
	NSMutableArray *fileChildren;
	NSString* _hash; //if this is different from server, refetch from server, intelligently modify
	NSDate* _modified;
}

@end

// File node is a leaf node, with no children.
@interface DropboxFileNode : NSObject {
	int _bytes;
	NSDate* _modified;
	NSString* _path;
	NSString* _root;
}

@end
