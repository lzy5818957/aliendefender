//
//  BulletObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "BulletObject.h"


@implementation BulletObject
@synthesize charge, direction;


-(void)update
{
    [super update];
    //rotation update
    if (abs(body->GetLinearVelocity().x) == 0.0 && abs(body->GetLinearVelocity().y) == 0.0) 
    {
        sprite.rotation = 0;
        
    }
    else {
        
        sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(atan2(body->GetLinearVelocity().y,body->GetLinearVelocity().x));
    }
    
}
@end
