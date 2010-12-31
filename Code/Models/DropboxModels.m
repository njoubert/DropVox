//
//  DropboxModels.m
//  DropVox
//
//  Created by Niels Joubert on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DropboxModels.h"


@implementation DropboxDirNode
@synthesize name;
@synthesize path;
@synthesize hash;
@synthesize modified;
@synthesize dirChildren;
@synthesize fileChildren;
@synthesize parent;

-(DropboxDirNode*) init {
	self = [super init];
	if (self) {	
		parent = nil;
		hash = [[NSString alloc] initWithString:@""];
		name = nil;
		path = nil;
		modified = nil;
		dirChildren = [[NSMutableArray alloc] init];
		fileChildren = [[NSMutableArray alloc] init];
	}
	return self;	
}

-(void)dealloc {
	[hash release];
	[super dealloc];
}
-(void)printMe:(int)indent {
	NSString* i = [@"" stringByPaddingToLength:indent withString: @"-" startingAtIndex:0];
	NSLog(@"%@d:{%@}", i, name);
	
	NSEnumerator* e = [self.fileChildren objectEnumerator];
	DropboxFileNode* subfile;
	while (subfile = (DropboxFileNode*) [e nextObject]) {
		[subfile printMe:(indent+1)];
	}
	
	NSEnumerator* e2 = [self.dirChildren objectEnumerator];
	DropboxDirNode* subdir;
	while (subdir = (DropboxDirNode*) [e2 nextObject]) {
		[subdir printMe:(indent+1)];
	}

	
	
}
@end

@implementation DropboxFileNode

@synthesize parent;
@synthesize name;
@synthesize bytes;
@synthesize modified;
@synthesize path;

-(DropboxFileNode*) initWithParent:(DropboxDirNode*)p {
	self = [super init];
	if (self) {		
		parent = p;
		bytes = 0;
		modified = nil;
		path = nil;
	}
	return self;	
}
-(void)printMe:(int)indent {
	NSString* i = [@"" stringByPaddingToLength:indent withString: @"-" startingAtIndex:0];
	NSLog(@"%@f:{%@}", i, name);	
}


@end

