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
        CCTexture2D *cannonTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"Arrow"]] autorelease];
        [textureDictionary setValue:cannonTexture forKey:@"Cannon"];
        
        //add PhysicalBulletTexture
        CCTexture2D *physicalBulletTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"Bullet"]] autorelease];
        [textureDictionary setValue:physicalBulletTexture forKey:@"PhysicalBullet"];
        
        //add ControllableBulletTexture
        CCTexture2D *controllableBulletTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"Bullet"]] autorelease];
        [textureDictionary setValue:controllableBulletTexture forKey:@"ControllableBullet"];
        
        //add UFOTexture
        CCTexture2D *ufoTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"ufo"]] autorelease];
        [textureDictionary setValue:ufoTexture forKey:@"UFO"];
        
        //add AlienTexture
        CCTexture2D *alienTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"Alien"]] autorelease];
        [textureDictionary setValue:alienTexture forKey:@"Alien"];
        
        //add AlienTexture
        CCTexture2D *chargeBarTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"ChargeBar"]] autorelease];
        [textureDictionary setValue:chargeBarTexture forKey:@"ChargeBar"];
        
        //add AlienTexture
        CCTexture2D *lifeBarTexture = [[[CCTexture2D alloc] initWithImage: [UIImage imageNamed:@"ChargeBar3"]] autorelease];
        [textureDictionary setValue:lifeBarTexture forKey:@"LifeBar"];
    }
    
    return textureDictionary;
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
