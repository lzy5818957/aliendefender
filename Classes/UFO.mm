//
//  UFO.mm
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-24.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "UFO.h"


@implementation UFO

-(id)initWithCoords:(CGPoint)p
{
    self = [super init];
    
	texture = [[CCTexture2D alloc] initWithString:@"UFO" fontName:@"Arial" fontSize:12.0f];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
	sprite.position = p;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	
	shape.SetAsBox(0.3f, 0.4f);
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;

    speed = 3.0;
    
    
	return self;
}
-(void)move
{
    [super move];
    if (body->GetLinearVelocity().Length() <= speed/10) 
    {
        
        body->ApplyForce(b2Vec2(-0.05*speed,0),body->GetWorldCenter());
    }
    
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
