//
//  HelpScene.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-03.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "HelpScene.h"


@implementation HelpScene
-(id) init{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	CCMenuItemFont *back = [CCMenuItemFont itemFromString:@"back" target:self selector: @selector(back:)];
    back.position = ccp(420, 20);
    
	CCMenu *menu = [CCMenu menuWithItems: back, nil];
	menu.position = ccp(0, 0);
	[self addChild: menu];
	
    CCSprite *bg = [CCSprite spriteWithFile: @"helpbg.png"];
	bg.position = ccp(240,160);
	[self addChild: bg z:-1];
	return self;
}

-(void) back: (id) sender{
	[SceneManager goMenu];
}

@end
