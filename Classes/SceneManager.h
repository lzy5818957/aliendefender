//
//  SceneManager.h
//  SceneManager
//
//  Created by MajorTom on 9/7/10.
//  Copyright iphonegametutorials.com 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MenuScene.h"
#import "GameScene.h"
#import "CreditsScene.h"

@interface SceneManager : NSObject {
}

+(void) goMenu;
+(void) goPlay;
+(void) goCredits;

@end
