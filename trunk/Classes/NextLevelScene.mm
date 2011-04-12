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
	
	CCMenuItemFont *ready = [CCMenuItemFont itemFromString:@"Ready" target:self selector: @selector(back:)];
    CCMenuItemFont *nextLevel = [CCMenuItemFont itemFromString: [NSString stringWithFormat: @"Next Level is %d", [[Resource PlayerData].currentLevel intValue]]];
	CCMenu *menu = [CCMenu menuWithItems: ready,nextLevel, nil];
	
	menu.position = ccp(160, 150);
	[self addChild: menu];
    [menu alignItemsVertically];
	return self;
}

-(void) back: (id) sender{
	[SceneManager goPlay];
}

@end
