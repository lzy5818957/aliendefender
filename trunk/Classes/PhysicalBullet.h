//
//  PhysicalBullet.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-3-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "BulletObject.h"


@interface PhysicalBullet : BulletObject {
    
}

-(id)initWithCoords:(CGPoint)p Charge:(double)c Direction:(CGPoint)dir;
-(void)update;
-(void)fire;
@end
