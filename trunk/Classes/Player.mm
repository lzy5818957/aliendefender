//
//  Player.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize currentWeaponType, cannon;

-(id)init
{
    self = [super init];
    //setDefaultWeapon
    currentWeaponType = TypePhysicalBullet;

    cannon = [[CannonObject alloc] initWithCoords:CGPointMake(20, 160)];
    return self;
}
-(PlayerWeaponObject*)loadWeaponCharge:(double) charge Direction:(CGPoint)dir
{
    PlayerWeaponObject* weapon;
    if(currentWeaponType == TypePhysicalBullet)
    {
        //Normallize CGpoint
        CGPoint direction = CGPointMake(dir.x/(pow(dir.x, 2)+(pow(dir.y, 2))), dir.y/(pow(dir.x, 2)+(pow(dir.y, 2))));
        weapon = [[PhysicalBullet alloc] initWithCoords:CGPointMake(20, 160) Charge:charge Direction:direction ];
    
    }
    
    return weapon;
}

-(void)dealloc
{
    [cannon release];
    [super dealloc];
}
@end
