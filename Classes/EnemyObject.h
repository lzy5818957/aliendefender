//
//  EnemyObject.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface EnemyObject : GameObject {

    float speed;

}
@property (nonatomic,readwrite) float speed;

@end
