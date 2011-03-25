//
//  ControlableBullet.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-24.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BulletObject.h"

@interface ControllableBullet : BulletObject {
    
}
-(id)initWithCoords:(CGPoint)p Charge:(double)c Direction:(CGPoint)dir;
-(void)update;
-(void)fire;
@end
