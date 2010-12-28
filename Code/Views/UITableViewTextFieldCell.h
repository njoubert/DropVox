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
	id _tar;
	SEL _sel;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isPassword:(bool)ispw;
- (void)setTextEntryShadowText:(NSString *)t;
- (bool)hasData;
- (NSString*) getData;

- (void) setTypingTarget:(id)t action:(SEL)s;
@end
