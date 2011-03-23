//
//  GameObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize sprite, bodyDef, body, fixture, fixtureDef, shape ,type ,toBeRemoved, texture;

-(id)init
{
    self = [super init];
    bodyDef.userData = self;
    fixtureDef.userData = self;
	toBeRemoved = NO;
    return self;
}

-(void)update
{
    //position update
    sprite.position = CGPointMake( body->GetPosition().x * PTM_RATIO, body->GetPosition().y * PTM_RATIO);
    //rotation update
    if (abs(body->GetLinearVelocity().x) == 0.0 && abs(body->GetLinearVelocity().y) == 0.0) 
    {
        sprite.rotation = 0;
        
    }
    else {
        
        sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(atan2(body->GetLinearVelocity().y,body->GetLinearVelocity().x));
    }

}

-(void)move
{
    
}

-(void) dealloc
{
	[sprite release];
    [texture release];
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
