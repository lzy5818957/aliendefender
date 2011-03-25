//
//  CannonObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-23.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "CannonObject.h"


@implementation CannonObject
-(id)initWithCoords:(CGPoint)p
{
    self = [super init];
    
	texture = [[CCTexture2D alloc] initWithString:@"--->>>" fontName:@"Arial" fontSize:12.0f];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
	sprite.position = p;
	bodyDef.type = b2_staticBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	
	shape.SetAsBox(0.7f, 0.2f);
	fixtureDef.shape = &shape;
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
    fixtureDef.isSensor = true;


	return self;
}

-(void)update
{
    //b2body uses radians for rotation, CCSprite uses Degree for rotation
    sprite.rotation= -CC_RADIANS_TO_DEGREES(body->GetAngle());

}

-(void)dealloc
{

    
    [super dealloc];
}

@end
