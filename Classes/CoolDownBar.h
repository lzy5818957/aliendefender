//
//  CoolDownBar.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-06.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface CoolDownBar : GameObject {
    
    float timeLeft;
    BOOL isAvaliable;
}

@property (nonatomic,readwrite) float timeLeft;
@property (nonatomic,readwrite) BOOL isAvaliable;

-(id)initWithCoords:(CGPoint)p;
-(void)update;
-(void)move;
-(void)resetTimer;
@end
