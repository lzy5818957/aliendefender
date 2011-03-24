//
//  PlayerLife.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-23.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "PlayerLife.h"


@implementation PlayerLife
@synthesize life;

-(id)initWithCoords:(CGPoint)p
{
    self = [super init];
    
    life = 10;

	texture = [[CCTexture2D alloc] initWithString:@"---" fontName:@"Arial" fontSize:16.0f];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
    sprite.anchorPoint = CGPointMake(0, 0);
	sprite.position = p;
	bodyDef.type = b2_staticBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	
	shape.SetAsBox(0.1f, 0.1f);
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
    fixtureDef.isSensor = true;
    type = TypeLife;
    
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

}

-(void)dealloc
{
    
    [super dealloc];
}

@end
