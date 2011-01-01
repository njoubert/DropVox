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
-(BOOL)containsDirOfName:(NSString*)n {
	NSEnumerator* e = [self.dirChildren objectEnumerator];
	DropboxDirNode* subdir;
	while (subdir = (DropboxDirNode*) [e nextObject]) {
		if ([subdir.name isEqual:n])
			return YES;
	}
	return NO;
}
-(BOOL)containsFileOfName:(NSString*)n {
	NSEnumerator* e = [self.fileChildren objectEnumerator];
	DropboxFileNode* subdir;
	while (subdir = (DropboxFileNode*) [e nextObject]) {
		if ([subdir.name isEqual:n])
			return YES;
	}
	return NO;	
}

-(DropboxDirNode*)getDirOfName:(NSString*)n {
	NSEnumerator* e = [self.dirChildren objectEnumerator];
	DropboxDirNode* subdir;
	while (subdir = (DropboxDirNode*) [e nextObject]) {
		if ([subdir.name isEqual:n])
			return subdir;
	}
	return nil;
}	

-(NSArray*)getContentsForDisplay {
	NSMutableArray* arr = [[NSMutableArray alloc] initWithCapacity:([self.dirChildren count] + [self.fileChildren count])];

	NSEnumerator* e2 = [self.dirChildren objectEnumerator];
	DropboxDirNode* subdir;
	while (subdir = (DropboxDirNode*) [e2 nextObject]) {
		[arr addObject:[subdir.name copy]];
	}
	
	NSEnumerator* e = [self.fileChildren objectEnumerator];
	DropboxFileNode* subfile;
	while (subfile = (DropboxFileNode*) [e nextObject]) {
		[arr addObject:[subfile.name copy]];
	}
		 
	return arr;
	
}
-(void)dealloc {
	[hash release];
	[super dealloc];
}
-(void)printMe:(int)indent {
	NSString* i = [@"" stringByPaddingToLength:indent withString: @"-" startingAtIndex:0];
	NSLog(@"%@d:{%@}", i, name);
		
	NSEnumerator* e2 = [self.dirChildren objectEnumerator];
	DropboxDirNode* subdir;
	while (subdir = (DropboxDirNode*) [e2 nextObject]) {
		[subdir printMe:(indent+1)];
	}

	NSEnumerator* e = [self.fileChildren objectEnumerator];
	DropboxFileNode* subfile;
	while (subfile = (DropboxFileNode*) [e nextObject]) {
		[subfile printMe:(indent+1)];
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

