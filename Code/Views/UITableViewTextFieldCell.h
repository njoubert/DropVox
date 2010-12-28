//
//  UITableViewTextFieldCell.h
//  DropVox
//
//  Created by Niels Joubert on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewTextFieldCell : UITableViewCell {
	UITextField *_textField;
}
- (void)setTextEntryShadowText:(NSString *)t;
@end
