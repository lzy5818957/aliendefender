//
//  Coin.mm
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-07.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "Coin.h"

#define MAX_AGE 400

@implementation Coin

-(id)init
{
    self = [super init];
    
    bodyDef.type = b2_staticBody;
    
    shape.SetAsBox(0.3f, 0.4f);
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
    //fixtureDef.isSensor = TRUE;
    speed = 0.0;
    return self;
}
-(void)move
{
    [super move];
    
}
-(void)update
{
    [super update];
    [self move];
    [self grow];
}

-(void)grow
{
    if(age < MAX_AGE)
    {
        age += 1;
    }
    else
    {
        toBeRemoved = YES;
    }
}

-(void)dealloc
{
    
    [super dealloc];
}

@end
