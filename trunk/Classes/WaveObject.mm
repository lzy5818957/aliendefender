//
//  Wave.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "WaveObject.h"


@implementation WaveObject
@synthesize numberOfEnemies, difficulty ,gameObjectType;




+(id)waveWithnumberOfEnemy: (int)number Difficulty:(float)diff Type:(GameObjectType)gOType
{
	return [[[self alloc] initWithnumberOfEnemy:number Difficulty:diff Type:gOType] autorelease];
	
}

-(id)initWithnumberOfEnemy: (int)number Difficulty:(float)diff Type:(GameObjectType)gOType
{
	[super init];
	[self setNumberOfEnemies:number];
	[self setDifficulty:diff];
	[self setGameObjectType:gOType];
	
	return self;
}
	 

- (void) dealloc
{
		

	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
