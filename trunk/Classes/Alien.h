//
//  Alien.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroundEnemyObject.h"
#import "GameConfig.h"

@interface Alien : GroundEnemyObject {

	
}

-(id)initWithCoords:(CGPoint)p;
-(void)update;
-(void)move;
@end
