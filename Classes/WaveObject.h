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

	NSNumber *numberOfEnemies;
	NSNumber *difficulty;
	GameObjectType gameObjectType;
	
}

@property(nonatomic,retain) NSNumber *numberOfEnemies;
@property(nonatomic,retain) NSNumber *difficulty;
@property(nonatomic,readwrite) GameObjectType gameObjectType;
+(id)waveWithnumberOfEnemy: (NSNumber *)number Difficulty:(NSNumber *)diff Type:(GameObjectType)gOType;
-(id)initWithnumberOfEnemy: (NSNumber *)number Difficulty:(NSNumber *)diff Type:(GameObjectType)gOType;
@end
