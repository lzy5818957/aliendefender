//
//  MenuLayer.h
//  MenuLayer
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "cocos2d.h"

#import "SceneManager.h"
#import "GameScene.h"

#import "BaseScene.h"

@interface MenuScene : BaseScene {
}

- (void)onNewGame:(id)sender;
- (void)onLevel:(id)sender;
- (void)onHelp:(id)sender;
@end
