    //
//  DropboxLoginViewController.m
//  DropVox
//
//  Created by Niels Joubert on 12/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DropboxLoginViewController.h"
#import "UITableViewTextFieldCell.h"

@implementation DropboxLoginViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	NSLog(@"DropboxLoginViewController loadView");
	
	_loginView = [[UITableView alloc] 
				initWithFrame:[[UIScreen mainScreen] applicationFrame] 
				style:UITableViewStyleGrouped];
	_loginView.delegate = self;
	_loginView.dataSource = self;
	self.view = _loginView;

	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSArray *array = [[NSArray alloc] initWithObjects:@"Email", @"Password", nil];
	[array release];
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;	
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) { return 2; }
	if (section == 1) { return 1; }	
	if (section == 2) { return 1; }	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForLoginPass:(NSIndexPath *)indexPath {
	static NSString *InputTableIdentifier = @"InputTableIdentifier";
	NSUInteger row = [indexPath row];
	
	UITableViewTextFieldCell* cell = [[[UITableViewTextFieldCell alloc] 
			 initWithStyle:UITableViewCellStyleValue1
			 reuseIdentifier:InputTableIdentifier] autorelease];
	if (row == 0) {
		cell.textLabel.text = @"Email";
		[cell setTextEntryShadowText:@"example@gmail.com"];					
	} else if (row == 1) {
		cell.textLabel.text = @"Password";
		[cell setTextEntryShadowText:@"Required" ];
	}
	return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForButton:(NSIndexPath *)indexPath {
	static NSString *ButtonTableIdentifier = @"ButtonTableIdentifier";
	NSUInteger sec = [indexPath section];

	UITableViewCell* cell = [[[UITableViewCell alloc] 
			 initWithStyle:UITableViewCellStyleDefault
			 reuseIdentifier:ButtonTableIdentifier] autorelease];
	
	cell.textLabel.textColor = [UIColor darkGrayColor];
	cell.textLabel.textAlignment = UITextAlignmentCenter;

	switch (sec) {
		case 1:
			cell.textLabel.text = @"Log into Dropbox";
			break;
		case 2:
			cell.textLabel.text = @"Sign up for Dropbox";
			break;
	}
	return cell;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = nil;	
	NSUInteger sec = [indexPath section];
		
	if (sec == 0) { cell = [self tableView:tableView cellForLoginPass:indexPath]; }
	if (sec == 1 || sec == 2) { cell = [self tableView:tableView cellForButton:indexPath]; }
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"Log In to Dropbox";
	} else if (section == 1) {
		return @"";
	} else {
		return @"";
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (section == 2) { return @"DropVox only plays the music you have in your Dropbox account. We don't save these credentials, we only use it once to register the app with Dropbox."; }
	return @"";
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger sec = [indexPath section];
	NSUInteger row = [indexPath row];

	NSString *message = [[NSString alloc] initWithFormat:@"You selected a row"];
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"Row Selected"
						  message:message
						  delegate:nil
						  cancelButtonTitle:@"Yup"
						  otherButtonTitles:nil];
	[alert show];
	
	[message release];
	[alert release];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
