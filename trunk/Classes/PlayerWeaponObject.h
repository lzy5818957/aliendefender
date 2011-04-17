//
//  PlayerWeaponObject.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface PlayerWeaponObject : GameObject {
    
    float attack;
    int rechargeTime;
}

@property (nonatomic,readwrite) float attack;
@property(nonatomic, readwrite)int rechargeTime;

-(void)update;
-(void)fire;
@end
