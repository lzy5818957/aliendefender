//
//  GameObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize sprite, bodyDef, body, fixture, fixtureDef, shape ,type ,toBeRemoved, texture, health;

-(id)init
{
    self = [super init];
    bodyDef.userData = self;
    fixtureDef.userData = self;
	toBeRemoved = NO;
    health = 100;
    return self;
}

-(void)update
{
    //dead update
    if (health <=0 ) {
        [self setToBeRemoved:true];
    }
    
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
-(void)damage:(int)amount
{
    health  -= amount;
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
