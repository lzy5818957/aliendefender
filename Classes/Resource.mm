//
//  Resource.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-24.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "Resource.h"



@implementation Resource



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
