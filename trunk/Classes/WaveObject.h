//
//  Wave.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObject.h"

@interface WaveObject : NSObject {

	int numberOfEnemies;
	float difficulty;
	GameObjectType gameObjectType;
	
}

@property(nonatomic,readwrite) int numberOfEnemies;
@property(nonatomic,readwrite) float difficulty;
@property(nonatomic,readwrite) GameObjectType gameObjectType;
+(id)waveWithnumberOfEnemy: (int)number Difficulty:(float)diff Type:(GameObjectType)gOType;
-(id)initWithnumberOfEnemy: (int)number Difficulty:(float)diff Type:(GameObjectType)gOType;
@end
