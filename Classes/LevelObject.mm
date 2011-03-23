//
//  LevelObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "LevelObject.h"


@implementation LevelObject

@synthesize waves;

+(id)levelWithLevelNumber:(NSNumber *)levelNumber
{
	return [[[self alloc] initWithLevelNumber:levelNumber] autorelease];

}
-(id)initWithLevelNumber:(NSNumber *)levelNumber
{
	[super init];
	//will give definition of level later
	waves = [NSMutableArray arrayWithObject:[WaveObject waveWithnumberOfEnemy:[NSNumber numberWithInt:10] Difficulty:[NSNumber numberWithFloat:1.2] Type:TypeAlien]];
	
	return self;
}

//return an array of GameObjects
-(NSMutableArray *)generateGameObject
{
	NSMutableArray *wavesArray = [NSMutableArray arrayWithCapacity:0];
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	for(WaveObject *wave in waves) {
		
		NSMutableArray *gameObjectArray = [NSMutableArray arrayWithCapacity:0];
		switch (wave.gameObjectType) {
				
			case TypeAlien:
				for (int i = 0; i < [wave.numberOfEnemies intValue] ; i++) 
				{
					[gameObjectArray addObject: [[[Alien alloc] initWithCoords:CGPointMake(screenSize.width, 30)] autorelease]];
				}
				break;
				
			default:
				break;
		}
		[wavesArray addObject:gameObjectArray];
	}

	return wavesArray;
}


-(void)dealloc
{
	[waves release];
	
	[super dealloc];
}
@end
