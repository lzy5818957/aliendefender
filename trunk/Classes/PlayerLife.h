//
//  PlayerLife.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-23.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface PlayerLife : GameObject {
    
    int life;
}

@property (nonatomic,readwrite) int life;

-(id)initWithCoords:(CGPoint)p;
-(void)update;
-(void)move;
@end
