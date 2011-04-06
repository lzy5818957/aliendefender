//
//  ChargeBar.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-05.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface ChargeBar : GameObject {
    
    float charge;
}
@property (nonatomic,readwrite) float charge;

-(id)initWithCoords:(CGPoint)p;
-(void)update;
-(void)move;
@end
