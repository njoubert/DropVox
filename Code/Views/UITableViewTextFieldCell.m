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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		
		_textField = [[[UITextField alloc] initWithFrame:CGRectMake(110.0, 13.0, 900.0, 30.0)] autorelease];
        _textField.tag = TEXTENTRY_TAG;
        _textField.font = [UIFont systemFontOfSize:15.0];
        _textField.textAlignment = UITextAlignmentLeft;
        _textField.textColor = [UIColor lightGrayColor];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
		_textField.text = @"hello";
        [self.contentView addSubview:_textField];
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTextEntryShadowText:(NSString *)t {
	_textField.text = t;
}


- (void)dealloc {
    [super dealloc];
}


@end
