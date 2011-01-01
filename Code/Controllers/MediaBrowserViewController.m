    //
//  MediaBrowserViewController.m
//  DropVox
//
//  Created by Niels Joubert on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MediaBrowserViewController.h"
#import "MediaManager.h"

@interface MediaBrowserViewController (hidden)

- (void)setupData;
- (void)createNavigationStack;

- (void)updateCurrentDataList;
- (void)updateDataWithChildDir:(DropboxDirNode*)child; //Navigating DOWN tree
- (void)updateDataWithParent; //Navigating UP tree

@end

@implementation MediaBrowserViewController

@synthesize currentNode;

- (MediaBrowserViewController*) initWithDropboxDir:(DropboxDirNode*)dir {
	self = [super init];
	if (self) {
		self.currentNode = dir;
	}
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	_mainView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,480.0f)];
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,44.0f,320.0f,416.0f)];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	
	_navBarView = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,44.0f)];
	_navBarView.delegate = self;
	
	_cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneBarButtonClicked:)];
	
	[self setupData];
	
	[_mainView addSubview:_navBarView];
	[_mainView addSubview:_tableView];
	self.view = _mainView;
}

- (void)setupData {
	[self createNavigationStack];
	[self updateCurrentDataList];
}

- (void)createNavigationStack {
	//create nagivation view hierarchy
	DropboxDirNode* cur = currentNode;
	NSMutableArray* stack = [[NSMutableArray alloc] init];
	while (cur != nil) {
		UINavigationItem* item;
		if (cur.parent == nil) {
			item = [[UINavigationItem alloc] initWithTitle:@"Root"];
		} else {
			item = [[UINavigationItem alloc] initWithTitle:[cur name]];			
		}
		NSLog(@"Creating navitem for dirnode with name:{%@}\n", [cur name]);
		item.rightBarButtonItem = _cancelButton;
		[stack insertObject:item atIndex:0];
		cur = cur.parent;
	}
	[_navBarView setItems:stack];	
}

- (void)updateCurrentDataList {
	_currentlyDisplayedData = [self.currentNode getContentsForDisplay];
	[_tableView reloadData];
}

//Navigating DOWN tree
- (void)updateDataWithChildDir:(DropboxDirNode*)child {
	NSLog(@"updateDataWithChildDir, navigating DOWN tree");
	self.currentNode = child;
	UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:[child name]];
	[_navBarView pushNavigationItem:navItem animated:YES];
	[self updateCurrentDataList];
}

//Navigating UP tree, called from popping navigationItem.
- (void)updateDataWithParent {
	NSLog(@"updateDataWithParent, navigating UP tree");
	self.currentNode = currentNode.parent;
	[self updateCurrentDataList];	
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Click Handling

- (void)doneBarButtonClicked:(id)sender {
	NSLog(@"Done button clicked. time to unload\n");
	
}


#pragma mark -
#pragma mark UINavigationBarDelegate Protocol

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
	// called at end of animation of push or immediately if not animated
	NSLog(@"Pushed item onto navbar, title:{%@}\n", item.title);
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
	NSLog(@"Popping item from navbar, title:{%@}\n", item.title);
	[self updateDataWithParent];
}

#pragma mark -
#pragma mark UITableViewDelegate Protocol

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	NSString* n = [_currentlyDisplayedData objectAtIndex:row];
	
	NSLog(@"Selected row %d, object name:{%@}\n", row, n);
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	DropboxDirNode* newNode;
	if ((newNode = [currentNode getDirOfName:n]) != nil) {
		[self updateDataWithChildDir:newNode];
	}
	
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [_currentlyDisplayedData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row]; 

	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
	if (cell == nil) { cell = [[[UITableViewCell alloc]
								initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	cell.textLabel.text = [_currentlyDisplayedData objectAtIndex:row];
	return cell;
}

@end
