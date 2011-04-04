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
        
        //add PhysicalBulletTexture
        CCTexture2D *physicalBulletTexture = [[CCTexture2D alloc] initWithImage:[UIImage imageNamed:@"Icon"]];
        [textureDictionary setValue:physicalBulletTexture forKey:@"PhysicalBullet"];
        
        //add ControllableBulletTexture
        CCTexture2D *controllableBulletTexture = [[CCTexture2D alloc] initWithString:@"ControllableBullet" 
                                                                        fontName:@"Arial" 
                                                                        fontSize:12.0f];
        [textureDictionary setValue:controllableBulletTexture forKey:@"ControllableBullet"];
        
        
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
