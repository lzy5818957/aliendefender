//
//  CoolDownBar.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-06.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "CoolDownBar.h"


@implementation CoolDownBar
@synthesize timeLeft,isAvaliable;

#define TOTAL_COOLDOWNTIME 100

-(id)initWithCoords:(CGPoint)p
{
    self = [super init];
    timeLeft = 0.0f;
    isAvaliable = YES;
	texture = [[Resource TextureDictionary] valueForKey:@"CoolDownBar"];
    
    CCProgressTimer* timer = [CCProgressTimer progressWithTexture:texture];
    timer.type = kCCProgressTimerTypeRadialCW;
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
    
    ((CCProgressTimer*)sprite).percentage = timeLeft;
    
    
    
    if (timeLeft <= 0)
    {
        isAvaliable = YES;
    }
    else
    {
        isAvaliable = NO;
        timeLeft -= 1;
    }
    [self move];
    
}

-(void)resetTimer
{
    timeLeft = 100;
}

-(void)dealloc
{
    
    [super dealloc];
}

@end
