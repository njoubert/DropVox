//
//  MediaBrowserViewController.h
//  DropVox
//
//  Created by Niels Joubert on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropboxModels.h"

@class MediaManager;

@interface MediaBrowserViewController : UIViewController <UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource> {
	UIView* _mainView;
	UINavigationBar* _navBarView;
	UITableView* _tableView;
	UIBarButtonItem* _cancelButton;
	DropboxDirNode* _currentNode;
}

@end
