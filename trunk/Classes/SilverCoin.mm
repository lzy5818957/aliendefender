//
//  SilverCoin.mm
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-07.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "SilverCoin.h"


@implementation SilverCoin

-(id)initWithCoords:(CGPoint)p
{
    self = [super init];
    
	texture = [[Resource TextureDictionary] valueForKey:@"SilverCoin"];
    sprite = [[CCSprite spriteWithTexture:texture] retain];
    
	sprite.position = p;

	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
	return self;
}

@end
