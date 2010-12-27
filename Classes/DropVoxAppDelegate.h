//
//  DropVoxAppDelegate.h
//  DropVox
//
//  Created by Niels Joubert on 12/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropVoxViewController;

@interface DropVoxAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DropVoxViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) DropVoxViewController *viewController;

@end

