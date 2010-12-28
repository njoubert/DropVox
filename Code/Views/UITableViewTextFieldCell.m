//
//  UITableViewTextFieldCell.m
//  DropVox
//
//  Created by Niels Joubert on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UITableViewTextFieldCell.h"

#define TEXTENTRY_TAG 1

@implementation UITableViewTextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isPassword:(bool)ispw {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		
		_textField = [[[UITextField alloc] initWithFrame:CGRectMake(110.0, 13.0, 900.0, 30.0)] autorelease];
        _textField.tag = TEXTENTRY_TAG;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.textAlignment = UITextAlignmentLeft;
        _textField.textColor = [UIColor darkGrayColor];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
		_textField.autocorrectionType = UITextAutocorrectionTypeNo;
		_textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		
		if (ispw) {
			_textField.keyboardType = UIKeyboardTypeDefault;
			_textField.secureTextEntry = YES;
		} else {
			_textField.keyboardType = UIKeyboardTypeEmailAddress;
		}
		
		[_textField addTarget:self action:@selector(typingDidOccur:) forControlEvents:UIControlEventEditingChanged];
		
        [self.contentView addSubview:_textField];
		
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:NO];
	if (selected) {
		[_textField becomeFirstResponder];
	} else {
		[_textField resignFirstResponder];		
	}
}

- (void)setTextEntryShadowText:(NSString *)t {
	_textField.placeholder = t;
}
- (void)typingDidOccur:(id)sender {
	if (_tar != nil) {
		[_tar performSelector:_sel withObject:self];
	}
}
- (void) setTypingTarget:(id)t action:(SEL)s {
	_tar = t;
	_sel = s;
}
- (bool)hasData {
	return [_textField.text length] > 0;
}
- (NSString*) getData {
	return [_textField.text copy];
}
- (void)dealloc {
    [super dealloc];
}


@end
