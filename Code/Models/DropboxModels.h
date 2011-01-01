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
	DropboxDirNode* parent; //null means root.
	NSString* name; //parsed as individual filename
	NSString* path; //as delivered by Dropbox API
	NSString* hash; //if this is different from server, refetch from server, intelligently modify
	NSDate* modified;
	NSMutableArray *dirChildren;
	NSMutableArray *fileChildren;
}
@property (retain, nonatomic) DropboxDirNode* parent;
@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) NSString* path;
@property (retain, nonatomic) NSString* hash;
@property (retain, nonatomic) NSDate* modified;
@property (retain, nonatomic) NSMutableArray *dirChildren;
@property (retain, nonatomic) NSMutableArray *fileChildren;
-(DropboxDirNode*) init;
-(BOOL)containsDirOfName:(NSString*)n;
-(BOOL)containsFileOfName:(NSString*)n;
-(NSArray*)getContentsForDisplay;
-(void)printMe:(int)indent;

@end

// File node is a leaf node, with no children.
@interface DropboxFileNode : NSObject {
	DropboxDirNode* parent;
	NSString* name;
	long long bytes;
	NSDate* modified;
	NSString* path;
}
-(DropboxFileNode*) initWithParent:(DropboxDirNode*)parent;
@property (retain, nonatomic) DropboxDirNode* parent;
@property (retain, nonatomic) NSString* name;
@property (assign, nonatomic) long long bytes;
@property (retain, nonatomic) NSDate* modified;
@property (retain, nonatomic) NSString* path;
-(void)printMe:(int)indent;
@end
