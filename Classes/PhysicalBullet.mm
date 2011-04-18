//
//  PhysicalBullet.m
//  AlienDefender
//
//  Created by Vincent on 11-3-16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PhysicalBullet.h"


@implementation PhysicalBullet


-(id)initWithCoords:(CGPoint)p Charge:(double)c Direction:(CGPoint)dir
{
    
    self = [super init];
    attack = 50;
	texture = [[Resource TextureDictionary] valueForKey:@"PhysicalBullet"];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
	sprite.position = p;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	
	shape.SetAsBox(0.3f, 0.4f);
	fixtureDef.shape = &shape;
	fixtureDef.density = 0.0f;
	fixtureDef.friction = 0.3f;
    fixtureDef.restitution = 1.0f;
    fixtureDef.filter.groupIndex = -1;

    
    charge = c;
    direction = dir;
    rechargeTime = 50;
    
	return self;
}

-(void)update
{
    [super update];
    [self move];
}

-(void)move
{

}

-(void)fire
{
    assert(body != nil);
    CGPoint p = CGPointMake(direction.x*charge, direction.y*charge);
    body->ApplyLinearImpulse(b2Vec2(p.x,p.y),body->GetWorldCenter());
    [SoundManager playPhysicalBulletShoot];
}
-(void)dealloc
{
    [super dealloc];
}
@end
