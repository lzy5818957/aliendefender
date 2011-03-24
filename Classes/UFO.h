//
//  UFO.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-24.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlyingEnemyObject.h"

@interface UFO : FlyingEnemyObject {
    
}
-(id)initWithCoords:(CGPoint)p;
-(void)update;
-(void)move;
@end
