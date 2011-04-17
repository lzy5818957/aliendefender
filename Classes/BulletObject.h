//
//  BulletObject.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerWeaponObject.h"

@interface BulletObject : PlayerWeaponObject {

    double charge;
    CGPoint direction;
}
@property(nonatomic, readwrite)double charge;
@property(nonatomic, readwrite)CGPoint direction;

@end
