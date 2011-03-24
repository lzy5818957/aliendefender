//
//  Ground.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-23.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "Ground.h"


@implementation Ground
-(id)init
{
    self = [super init];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    texture = [[CCTexture2D alloc] initWithString:@"Ground" fontName:@"Arial" fontSize:12.0f];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
	sprite.position = CGPointMake(200, 300);
	bodyDef.position.Set(0, 0);
	
    shape.SetAsEdge(b2Vec2(0,0.5), b2Vec2(screenSize.width/PTM_RATIO,0.5));
	fixtureDef.shape = &shape;
    
    type = TypeGround;
    
    
    return self;
}
@end
