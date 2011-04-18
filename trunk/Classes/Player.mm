//
//  Player.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize currentWeaponType, cannon, playerLife, chargeBar, coolDownBar;

-(id)init
{
    self = [super init];
    //setDefaultWeapon
    currentWeaponType = [ControllableBullet class];
    //place the cannon in the middle of screen
    //Remember Initiallize these in gameworld
    cannon = [[CannonObject alloc] initWithCoords:CGPointMake(20, [CCDirector sharedDirector].winSize.height/2)];
    playerLife = [[PlayerLife alloc] initWithCoords:CGPointMake(90, 305)];
    chargeBar = [[ChargeBar alloc] initWithCoords:CGPointMake(400, 305)];
    coolDownBar = [[CoolDownBar alloc] initWithCoords:CGPointMake(40, 80)];
    return self;
}
-(PlayerWeaponObject*)loadWeaponCharge:(double) charge Direction:(CGPoint)dir
{
    PlayerWeaponObject* weapon;
    if(currentWeaponType == [PhysicalBullet class])
    {
        weapon = [[PhysicalBullet alloc] initWithCoords:CGPointMake(20, cannon.sprite.position.y) Charge:charge Direction:dir ];
    }
    if(currentWeaponType == [ControllableBullet class])
    {
        weapon = [[ControllableBullet alloc] initWithCoords:CGPointMake(20, cannon.sprite.position.y) Charge:charge+1 Direction:dir ];
    }
    return weapon;
}


-(void)playerLoseALife
{
    playerLife.life -= 1;
}

-(void)changeWeapon
{
    if (currentWeaponType == [PhysicalBullet class]) {
        currentWeaponType = [ControllableBullet class];
    }
    else
    {
        currentWeaponType = [PhysicalBullet class];
    }
}

-(void)dealloc
{
    [playerLife release];
    [cannon release];
    [super dealloc];
}
@end
