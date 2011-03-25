//
//  GameObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize sprite, bodyDef, body, fixture, fixtureDef, shape ,toBeRemoved, texture, health;

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
    
    //position update
    sprite.position = CGPointMake( body->GetPosition().x * PTM_RATIO, body->GetPosition().y * PTM_RATIO);
    
    //dead update
    CGSize winsize = [CCDirector sharedDirector].winSize;
    //if the gameObject is dead or out of bound
    if (health <= 0 || sprite.position.x < 0 || sprite.position.y < 0 ||
        sprite.position.x > winsize.width + 50 || sprite.position.y > winsize.height + 30) 
    {
        [self setToBeRemoved:true];
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
