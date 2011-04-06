//
//  ChargeBar.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-05.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "ChargeBar.h"


@implementation ChargeBar
@synthesize charge;

-(id)initWithCoords:(CGPoint)p
{
    self = [super init];
    charge = 0.0f;
	texture = [[Resource TextureDictionary] valueForKey:@"ChargeBar"];
    
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

    ((CCProgressTimer*)sprite).percentage = charge*20;
    if (charge >= 5)
    {
        charge = 5;
    }

    [self move];
    
}

-(void)dealloc
{
    
    [super dealloc];
}

@end
