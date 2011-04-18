//
//  NextLevelScene.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-11.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "NextLevelScene.h"


@implementation NextLevelScene
-(id) init{
	self = [super init];
	if (!self) {
		return nil;
	}
	

    CCMenuItemFont *nextLevel = [CCMenuItemFont itemFromString: [NSString stringWithFormat: @"Next Level is %d", [[Resource PlayerData].currentLevel intValue]]];
    CCMenuItemFont *ready = [CCMenuItemFont itemFromString:@"Ready" target:self selector: @selector(back:)];
	CCMenu *menu = [CCMenu menuWithItems: nextLevel,ready, nil];
	
	menu.position = ccp(240, 160);
	[self addChild: menu];
    [menu alignItemsVertically];
    [self saveLastLevelData];
	return self;
}

-(void)saveLastLevelData
{
    

}

-(void) back: (id) sender{
	[SceneManager goPlay];
}

@end
