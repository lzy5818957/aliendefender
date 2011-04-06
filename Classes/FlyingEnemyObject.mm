//
//  FlyingEnemyObject.mm
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-16.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "FlyingEnemyObject.h"


@implementation FlyingEnemyObject

-(id)init
{
    self = [super init];
    fixtureDef.filter.groupIndex = -3;
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
