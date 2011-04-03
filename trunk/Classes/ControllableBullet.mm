//
//  ControlableBullet.mm
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-24.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "ControllableBullet.h"


@implementation ControllableBullet
-(id)initWithCoords:(CGPoint)p Charge:(double)c Direction:(CGPoint)dir
{
    
    self = [super init];
    attack = 80;
	texture = [[CCTexture2D alloc] initWithString:@"ControllableBullet" fontName:@"Arial" fontSize:12.0f];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
	sprite.position = p;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	
	shape.SetAsBox(0.3f, 0.4f);
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
    fixtureDef.filter.groupIndex = -1;

    
    charge = c;
    direction = dir;
    
	return self;
}

-(void)update
{
    [super update];
    [self move];
}
-(void)move
{
    CGPoint controlForce = [Resource AcceValue];
    body->ApplyForce(b2Vec2(0,body->GetMass()*10.1),body->GetWorldCenter());
    
    if (body->GetLinearVelocity().Length() <= 10)  {
        body->ApplyForce(b2Vec2(0,controlForce.x*5),body->GetWorldCenter());

    }
    
}
-(void)fire
{
    assert(body != nil);
    CGPoint p = CGPointMake(direction.x*charge/3, direction.y*charge/3);
    body->ApplyLinearImpulse(b2Vec2(p.x,p.y),body->GetWorldCenter());
    
}

@end
