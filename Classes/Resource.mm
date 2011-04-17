//
//  Resource.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-24.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "Resource.h"

static float accelX;
static float accelY;


@implementation Resource

-(void)releaseTexture
{
    //TODO: Release textureDictionary here
    
}

+(NSMutableDictionary*)TextureDictionary
{
    static NSMutableDictionary *textureDictionary;
    
    /*[[NSNotificationCenter defaultCenter] addObserver: self
     selector: @selector(releaseTexture)
     name: UIApplicationWillTerminateNotification
     object: nil];*/
    
    if (textureDictionary == nil) {
        textureDictionary = [[NSMutableDictionary dictionaryWithCapacity:0] retain];
        
        //add CannonTexture
        CCTexture2D *cannonTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"arrow"]] autorelease];
        [textureDictionary setValue:cannonTexture forKey:@"Cannon"];
        
        //add PhysicalBulletTexture
        CCTexture2D *physicalBulletTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"bullet"]] autorelease];
        [textureDictionary setValue:physicalBulletTexture forKey:@"PhysicalBullet"];
        
        //add ControllableBulletTexture
        CCTexture2D *controllableBulletTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"bullet"]] autorelease];
        [textureDictionary setValue:controllableBulletTexture forKey:@"ControllableBullet"];
        
        //add UFOTexture
        CCTexture2D *ufoTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"ufo"]] autorelease];
        [textureDictionary setValue:ufoTexture forKey:@"UFO"];
        
        //add AlienTexture
        CCTexture2D *alienTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"Alien"]] autorelease];
        [textureDictionary setValue:alienTexture forKey:@"Alien"];
        
        //add SilverCoin
        CCTexture2D *silverCoin = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"SilverCoin"]] autorelease];
        [textureDictionary setValue:silverCoin forKey:@"SilverCoin"];
        
        //add ChargeBar
        CCTexture2D *chargeBarTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"ChargeBar"]] autorelease];
        [textureDictionary setValue:chargeBarTexture forKey:@"ChargeBar"];
        
        //add LifeBar
        CCTexture2D *lifeBarTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"ChargeBar3"]] autorelease];
        [textureDictionary setValue:lifeBarTexture forKey:@"LifeBar"];
        
        //add CoolDownBar
        CCTexture2D *coolDownBarTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"CoolDownBar"]] autorelease];
        [textureDictionary setValue:coolDownBarTexture forKey:@"CoolDownBar"];
        
        //add directionBtn
        CCTexture2D *directionBtn = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"DirectionBtn"]] autorelease];
        [textureDictionary setValue:directionBtn forKey:@"DirectionBtn"];
        
        //add PhyscialBulletBtn
        CCTexture2D *physicalBulletBtn = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"physicalBulletBtn"]] autorelease];
        [textureDictionary setValue:physicalBulletBtn forKey:@"physicalBulletBtn"];
        CCTexture2D *physicalBulletBtn_over = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"physicalBulletBtn_over"]] autorelease];
        [textureDictionary setValue:physicalBulletBtn_over forKey:@"physicalBulletBtn_over"];
        
        //add ControllableBulletBtn
        CCTexture2D *controllableBulletBtn = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"controllableBulletBtn"]] autorelease];
        [textureDictionary setValue:controllableBulletBtn forKey:@"controllableBulletBtn"];
        CCTexture2D *controllableBulletBtn_over = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"controllableBulletBtn_over"]] autorelease];
        [textureDictionary setValue:controllableBulletBtn_over forKey:@"controllableBulletBtn_over"];
    }
    
    return textureDictionary;
}

+(PlayerData*)PlayerData
{
    static PlayerData* playerData;
    
    NSArray* arrayOfPlayer = [ [ CoreDataHelper sharedCoreDataHelper ] getAllObjectsOfType: @"PlayerData" predicateString: nil ];
    
    if ([arrayOfPlayer count] == 0) {
        
        playerData = ( PlayerData* )[ [ CoreDataHelper sharedCoreDataHelper ] createObjectOfType: @"PlayerData" ];
        playerData.currentLevel = [ NSNumber numberWithInt: 1 ];
        playerData.currentAvalibaleLevel = [ NSNumber numberWithInt: 1 ];
        [ [ CoreDataHelper sharedCoreDataHelper ] save ];
    }
    else
    {
        for ( PlayerData* currentPlayer in arrayOfPlayer )
        {
            playerData = currentPlayer;
        }
        
    }
    return playerData;
}


+(CGPoint)AcceValue
{
    return CGPointMake(accelX, accelY);
    

}

+(void)SetAcceValue:(CGPoint)acceValue
{
    
    accelX = acceValue.x;
    accelY = acceValue.y;
}
@end
