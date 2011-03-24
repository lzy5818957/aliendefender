//
//  GroundGameObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-3-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GroundEnemyObject.h"


@implementation GroundEnemyObject

-(id)init
{
    self = [super init];
    fixtureDef.filter.groupIndex = -2;
    return self;
}

-(void)move
{
    if (body->GetLinearVelocity().Length() <= speed/10) 
    {
        body->ApplyForce(b2Vec2((-1)*speed,0),body->GetWorldCenter());
    }
}

@end
