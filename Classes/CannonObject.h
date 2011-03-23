//
//  CannonObject.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-23.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface CannonObject : GameObject {
    
}
-(id)initWithCoords:(CGPoint)p;
-(void)update;

@end
