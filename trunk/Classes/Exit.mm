//
//  Exit.mm
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-23.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "Exit.h"


@implementation Exit

@synthesize delegate;

-(id)init
{
    self = [super init];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    texture = [[CCTexture2D alloc] initWithString:@"Exit" fontName:@"Arial" fontSize:12.0f];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
	sprite.position = CGPointMake(200, 300);
	bodyDef.position.Set(0, 0);
	
    shape.SetAsEdge(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(0,0));
	fixtureDef.shape = &shape;
    //fixtureDef.isSensor = true;
    type = TypeExit;
    
    
    return self;
}
-(void)enemyDidPassExit
{
    [delegate playerLoseALife];
}
@end
