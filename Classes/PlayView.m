//
//  PlayView.m
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayView.h"
#import <UIKit/UIImage.h>
#import <UIKit/UIImageView.h>

@implementation PlayView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

		self.backgroundColor = [UIColor darkGrayColor];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)];
		label.text = @"Hello World";
		label.center = self.center;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		
		UIImage* btn_play =			[UIImage imageNamed:@"btn_play.png"];
		UIImage* btn_play_pressed = [UIImage imageNamed:@"btn_play_pressed.png"];
		UIImage* btn_pause =		[UIImage imageNamed:@"btn_pause.png"];
		UIImage* btn_pause_pressed = [UIImage imageNamed:@"btn_pause_pressed.png"];		
		
		playPauseButton = [[UIPlayPauseButton alloc] 
						   initWithFrame:CGRectMake(0.0f, 0.0f, 120.0f, 120.0f) 
						   playButton:btn_play 
						   playButtonPressed:btn_play_pressed 
						   pauseButton:btn_pause 
						   pauseButtonPressed:btn_pause_pressed];
		[playPauseButton addTarget:self action:@selector(playPauseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:playPauseButton];
		  
	}
    return self;	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)playPauseButtonClicked:(id)sender {
	UIButton *button = (UIButton *)sender;
	NSString *text = button.currentTitle;
	NSString *string = [[NSString alloc] initWithFormat:@"Button %@ pressed.", text];
	
	NSLog(@"button clicked. button title:%@", text);
	
	
	label.text = string;
	[string release];
}

- (void)dealloc {
    [super dealloc];
}


@end
