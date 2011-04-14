//
//  Coin.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-07.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaticEnemyObject.h"

@interface Coin : StaticEnemyObject {
    
}
-(void)update;
-(void)move;
-(void)grow;
@end
