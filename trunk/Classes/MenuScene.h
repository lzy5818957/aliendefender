//
//  MenuLayer.h
//  MenuLayer
//
//  Created by MajorTom on 9/7/10.
//  Copyright iphonegametutorials.com 2010. All rights reserved.
//


#import "cocos2d.h"

#import "SceneManager.h"
#import "GameScene.h"
#import "CreditsScene.h"

#import "BaseScene.h"

@interface MenuScene : BaseScene {
}

- (void)onNewGame:(id)sender;
- (void)onCredits:(id)sender;
@end
