//
//  SoundManager.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-17.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SoundManager : NSObject {
    
}
+(void)playPhysicalBulletShoot;
+(void)playControllableBulletShoot;
+(void)bulletHitEnemy;

@end
