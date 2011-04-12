//
//  GameWorld.h
//  AlienDefense
//
//  Created by Zunyi Lin on 11-03-10.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
#import "GLES-Render.h"
#import "cocos2d.h"
#import "GameConfig.h"
#import "MyContactListener.h"
#import "GameObject.h"
#import "Alien.h"
#import "Player.h"
#import "Ground.h"
#import "Exit.h"


@protocol GameWorldDelegate 

@required
-(void)graphicalRealize:(GameObject*)gameObject;
-(void)graphicalRemove:(GameObject*)gameObject;
@end


@interface GameWorld : NSObject {
	
	b2World* world;
	GLESDebugDraw *m_debugDraw;
    MyContactListener *_contactListener;
	id <GameWorldDelegate> delegate;
	NSMutableArray *gameObjectReadyQueue;
    NSMutableArray *weaponArray;
	NSMutableArray *currentOnSceneArray;
	NSMutableArray *toBeRemovedArray;
    ScreenBoundryObject *boundry;
    ScreenBoundryObject *exit;
    Player *player;
    ccTime accumlator;
    BOOL levelInTransition;
    

}

@property (nonatomic,readwrite) b2World* world;
@property (nonatomic,readwrite) GLESDebugDraw *m_debugDraw;
@property (nonatomic,readonly) MyContactListener *_contactListener;
@property (nonatomic,readonly) BOOL levelInTransition;
@property (nonatomic, retain) id <GameWorldDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *gameObjectReadyQueue;
@property (nonatomic, retain) NSMutableArray *weaponArray;
@property (nonatomic, retain) NSMutableArray *currentOnSceneArray;
@property (nonatomic, retain) NSMutableArray *toBeRemovedArray;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) GameObject *boundry;
@property (nonatomic, retain) GameObject *exit;

-(void)initWorld;
-(void)initDebugMode;
-(void)initBoundry;
-(void)initPlayer;

-(void)realizeGameObject:(GameObject*) gameObject;
-(void)physicalRealize:(GameObject*) gameObject;

-(void)update:(ccTime)dt;

-(void)emitEnemy;
-(void)emitWeapon;
-(void)setUpPlayerWeapon;
-(void)cleanUpDeadGameObject;

-(void)levelPassed;

@end
