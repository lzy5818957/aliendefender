//
//  SceneManager.h
//  SceneManager
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MenuScene.h"
#import "GameScene.h"
#import "LevelScene.h"
#import "HelpScene.h"
#import "NextLevelScene.h"

@interface SceneManager : NSObject {
}

+(void) goMenu;
+(void) goPlay;
+(void) goLevel;
+(void) goHelp;
+(void) goNextLevel;
@end
