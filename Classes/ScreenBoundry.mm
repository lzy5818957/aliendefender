//
//  ScreenBoundry.m
//  AlienDefender
//
//  Created by Vincent on 11-3-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ScreenBoundry.h"


@implementation ScreenBoundry

-(id)init
{
    self = [super init];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
    texture = [[CCTexture2D alloc] initWithString:@"BackGround" fontName:@"Arial" fontSize:12.0f];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
	sprite.position = CGPointMake(200, 300);
	bodyDef.position.Set(0, 0);
	
    shape.SetAsEdge(b2Vec2(0,0.5), b2Vec2(screenSize.width/PTM_RATIO,0.5));
	fixtureDef.shape = &shape;

    type = TypeGroundBoundry;
    
    
    return self;
}
@end
