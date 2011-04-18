//
//  GameObject.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GameConfig.h"
#import "Resource.h"
#import "ScoreData.h"
@interface GameObject : NSObject {

	@protected
    CCSprite *sprite;
	b2Body *body;
	b2Fixture *fixture;
	@public
	b2BodyDef bodyDef;
	b2FixtureDef fixtureDef;
	b2PolygonShape shape;

	Boolean toBeRemoved;
    CCTexture2D *texture;
    float health;
    
    
}

@property (nonatomic,retain) CCSprite *sprite;
@property (nonatomic,readwrite) b2BodyDef bodyDef;
@property (nonatomic,readwrite) b2Body *body;
@property (nonatomic,readwrite) b2Fixture *fixture;
@property (nonatomic,readwrite) b2PolygonShape shape;
@property (nonatomic,readwrite) b2FixtureDef fixtureDef;

@property (nonatomic,readwrite) Boolean toBeRemoved;
@property (nonatomic,retain) CCTexture2D *texture;
@property (nonatomic,readwrite) float health;
//Shape must be initiallized before calling this method while extending this class

-(void)update;
-(void)damage:(int)amount;
-(void)move;
@end
