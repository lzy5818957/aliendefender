//
//  PlayerLife.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-23.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "PlayerLife.h"
#import "SceneManager.h"

@implementation PlayerLife
@synthesize life;

-(id)initWithCoords:(CGPoint)p
{
    self = [super init];
    
    life = 20;
    
	texture = [[Resource TextureDictionary] valueForKey:@"LifeBar"];
    
    CCProgressTimer* timer = [CCProgressTimer progressWithTexture:texture];
    timer.type = kCCProgressTimerTypeHorizontalBarLR;
    timer.percentage = 0;
    
    sprite = (CCSprite*)timer;

	sprite.position = p;
	bodyDef.type = b2_staticBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	
	shape.SetAsBox(0.1f, 0.1f);
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
    fixtureDef.isSensor = true;

    
	return self;
}
-(void)move
{
    [super move];
    
}
-(void)update
{   
    [super update];
    
    ((CCProgressTimer*)sprite).percentage = life*5;
    if (life == 0)
    {
        //TODO: Delegate methods
    }
    
    [self move];

}

-(void)dealloc
{
    
    [super dealloc];
}

@end
