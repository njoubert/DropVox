//
//  DropboxLoginViewController.h
//  DropVox
//
//  Created by Niels Joubert on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropboxLoginView;
@class UITableViewTextFieldCell;

@interface DropboxLoginViewController : UIViewController 
		<UITableViewDelegate, UITableViewDataSource> {
	UITableView* _loginView;
	UITableViewTextFieldCell* emailFieldCell;
	UITableViewTextFieldCell* passFieldCell;
	NSString* _email;
	NSString* _passwd;		
			
}

-(bool)hasEmailAndPasswd;

@property (retain, nonatomic) UITableViewTextFieldCell* emailFieldCell;
@property (retain, nonatomic) UITableViewTextFieldCell* passFieldCell;

@end
