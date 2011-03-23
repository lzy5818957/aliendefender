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
    
	texture = [[CCTexture2D alloc] initWithString:@"PhysicalBullet" fontName:@"Arial" fontSize:12.0f];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
	sprite.position = p;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	
	shape.SetAsBox(0.3f, 0.4f);
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
    fixtureDef.filter.groupIndex = -1;
    type = TypePhysicalBullet;
    
    charge = c;
    direction = dir;
    
	return self;
}

-(void)update
{
    [super update];
}
-(void)fire
{
    assert(body != nil);
    CGPoint p = CGPointMake(direction.x*charge, direction.y*charge);
    body->ApplyLinearImpulse(b2Vec2(p.x,p.y),body->GetWorldCenter());

}
@end
