//
//  StaticEnemyObject.mm
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-07.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "StaticEnemyObject.h"


@implementation StaticEnemyObject

-(id)init
{
    self = [super init];
    age = 0;
    fixtureDef.filter.groupIndex = -4;
    return self;
}

-(void)move
{
    //flying
    if (sprite.position.y <= 280) 
    {
        
        body->ApplyForce(b2Vec2(0,body->GetMass()*10.5),body->GetWorldCenter());
    }
    
}
-(void)update
{
    [super update];
    
}

@end
