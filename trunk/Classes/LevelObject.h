//
//  LevelObject.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaveObject.h"
#import "GameObject.h"
#import "Alien.h"

@interface LevelObject : NSObject {

		NSArray *waves;
}
@property(nonatomic,retain)	NSArray *waves;
+(id)levelWithLevelNumber:(int)levelNumber;
-(id)initWithLevelNumber:(int)levelNumber;
-(NSMutableArray *)generateGameObject;
@end
