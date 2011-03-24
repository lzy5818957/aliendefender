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

+(id)levelWithLevelNumber:(int)levelNumber
{
	return [[[self alloc] initWithLevelNumber:levelNumber] autorelease];

}
-(id)initWithLevelNumber:(int)levelNumber
{
    waves = [NSMutableArray arrayWithCapacity:0];
	[super init];
    if (levelNumber == 1) {
        
        //will give definition of level later
        WaveObject *wave1 = [WaveObject waveWithnumberOfEnemy:10 Difficulty:1.2 Type:TypeAlien];
        WaveObject *wave2 = [WaveObject waveWithnumberOfEnemy:10 Difficulty:0.3 Type:TypeUFO];

        [waves addObject:wave1];
        [waves addObject:wave2];
    }

	
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
				for (int i = 0; i < wave.numberOfEnemies ; i++) 
				{
                    GameObject *gameObject = [[[Alien alloc] initWithCoords:CGPointMake(screenSize.width, 30)] autorelease];
					[gameObjectArray addObject: gameObject];
                    gameObject.health = (gameObject.health)*(wave.difficulty);
                    
				}
				break;
            case TypeUFO:
				for (int i = 0; i < wave.numberOfEnemies ; i++) 
				{
                    GameObject *gameObject = [[[UFO alloc] initWithCoords:CGPointMake(screenSize.width, 300)] autorelease];
					[gameObjectArray addObject: gameObject];
                    gameObject.health = (gameObject.health)*(wave.difficulty);
                    
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
