//
//  GameScene.h
//  AlienDefense
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameWorld.h"
#import "MyContactListener.h"
#import "LevelObject.h"
#import "Resource.h"
#import "BaseScene.h"
#import "SceneManager.h"
#import "PlayerData.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.


@interface GameScene : BaseScene <GameWorldDelegate> {

	GameWorld *gameWorld;
	LevelObject *level;
    
    CGPoint rTouchStartLocation;
    CGPoint weaponDirection;
    float angle;
    float chargeTimer;
    BOOL chargeStart;

}

@property(nonatomic,retain) GameWorld *gameWorld;
@property(nonatomic,retain) LevelObject *level;

@property(nonatomic,readonly) CGPoint weaponDirection;
// returns a Scene that contains the GameScene as the only child
+(id) scene;
-(void) back: (id) sender;
-(void) pause: (id) sender;
-(void) play: (id) sender;
-(void) changeWeapon: (id) sender;
@end
