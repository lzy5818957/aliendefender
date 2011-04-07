//
//  Player.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "PlayerWeaponObject.h"
#import "PhysicalBullet.h"
#import "ControllableBullet.h"
#import "CannonObject.h"
#import "PlayerLife.h"
#import "Exit.h"
#import "ChargeBar.h"
#import "CoolDownBar.h"

@interface Player : NSObject <ExitDelegate> {
    Class currentWeaponType;
    CannonObject *cannon;
    PlayerLife *playerLife;
    ChargeBar *chargeBar;
    CoolDownBar *coolDownBar;
    
}

@property (nonatomic,retain) Class currentWeaponType;
@property (nonatomic,retain) CannonObject *cannon;
@property (nonatomic,retain) PlayerLife *playerLife;
@property (nonatomic,retain) ChargeBar *chargeBar;
@property (nonatomic,retain) CoolDownBar *coolDownBar;

-(PlayerWeaponObject*)loadWeaponCharge:(double) charge Direction:(CGPoint)dir;
@end
