//
//  AlienDefenderAppDelegate.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright University Of Saskatchewan 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

#import "RootViewController.h"
#import "GameConfig.h"
#import "SceneManager.h"

@class RootViewController;

@interface AlienDefenderAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
