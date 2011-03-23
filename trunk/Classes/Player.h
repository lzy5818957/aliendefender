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
@interface Player : NSObject {

    GameObjectType currentWeaponType;
    CannonObject *cannon;
    
}

@property (nonatomic,readwrite) GameObjectType currentWeaponType;
@property (nonatomic,retain) CannonObject *cannon;

-(PlayerWeaponObject*)loadWeaponCharge:(double) charge Direction:(CGPoint)dir;
@end
