//
//  SoundManager.mm
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-17.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "SoundManager.h"
//#import "CDAudioManager.h"
#import "SimpleAudioEngine.h"
//#import "CocosDenshion.h"

@implementation SoundManager

+(void)playPhysicalBulletShoot
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"physicalBulletShoot.wav" ];
}
+(void)playControllableBulletShoot
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"controllableBulletShoot.wav" ];
}
+(void)bulletHitEnemy
{
    
}
@end
