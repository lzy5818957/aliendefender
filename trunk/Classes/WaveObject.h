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
	Class enemyType;
	
}

@property(nonatomic,readwrite) int numberOfEnemies;
@property(nonatomic,readwrite) float difficulty;
@property(nonatomic,retain) Class enemyType;
+(id)waveWithnumberOfEnemy: (int)number Difficulty:(float)diff Type:(Class)gOSubType;
-(id)initWithnumberOfEnemy: (int)number Difficulty:(float)diff Type:(Class)gOSubType;
@end
