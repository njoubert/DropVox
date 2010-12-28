//
//  DropboxLoginViewController.h
//  DropVox
//
//  Created by Niels Joubert on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropboxLoginView;

@interface DropboxLoginViewController : UIViewController 
		<UITableViewDelegate, UITableViewDataSource> {
	UITableView* _loginView;
}

@end
