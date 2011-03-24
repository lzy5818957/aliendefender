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
#import "CannonObject.h"
#import "PlayerLife.h"
#import "Exit.h"
@interface Player : NSObject <ExitDelegate> {

    GameObjectType currentWeaponType;
    CannonObject *cannon;
    PlayerLife *playerLife;
    
}

@property (nonatomic,readwrite) GameObjectType currentWeaponType;
@property (nonatomic,retain) CannonObject *cannon;
@property (nonatomic,retain) PlayerLife *playerLife;
-(PlayerWeaponObject*)loadWeaponCharge:(double) charge Direction:(CGPoint)dir;
@end
