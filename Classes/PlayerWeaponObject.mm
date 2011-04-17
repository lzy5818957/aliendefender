//
//  PlayerWeaponObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "PlayerWeaponObject.h"
#define MAX_AGE 250

@implementation PlayerWeaponObject
@synthesize attack,rechargeTime, age;

-(id)init
{
    self = [super init];

    return self;
    
}

-(void)update
{
    [super update];
    [self grow];

}

-(void)grow
{
    if(age < MAX_AGE)
    {
        age += 1;
    }
    else
    {
        toBeRemoved = YES;
    }
}

-(void)fire
{
    
}
@end
