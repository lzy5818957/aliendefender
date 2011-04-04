//
//  MenuLayer.m
//  MenuLayer
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//
#import "MenuScene.h"

@implementation MenuScene

-(id) init{
	self = [super init];
		
	float delayTime = 0.3f;
	
    
    //Main menu
	CCMenuItemImage *startNew = [CCMenuItemImage itemFromNormalImage:@"newGameBtn.png" selectedImage:@"newGameBtn_over.png" target:self selector:@selector(onNewGame:)];

	CCMenuItemImage *credits = [CCMenuItemImage itemFromNormalImage:@"levelBtn.png" selectedImage:@"levelBtn_over.png" target:self selector:@selector(onCredits:)];
        
	CCMenu *menu = [CCMenu menuWithItems:startNew, credits, nil];
	
	for (CCMenuItemFont *each in [menu children]) {
		each.scaleX = 0.0f;
		each.scaleY = 0.0f;
		CCAction *action = [CCSequence actions:
							[CCDelayTime actionWithDuration: delayTime],
							[CCScaleTo actionWithDuration:0.5F scale:1.0],
							nil];
		delayTime += 0.2f;
		[each runAction: action];
	}
	



	
	menu.position = ccp(240, 160);
	[menu alignItemsVerticallyWithPadding: 40.0f];
	[self addChild:menu z: 2];
    
    
    //help menu
    
    CCMenuItemImage *help = [CCMenuItemImage itemFromNormalImage:@"helpBtn.png" selectedImage:@"helpBtn_over.png" target:self selector:@selector(onHelp:)];

    CCMenu *helpMenu = [CCMenu menuWithItems:help, nil];
	
	for (CCMenuItemFont *each in [helpMenu children]) {
		each.scaleX = 0.0f;
		each.scaleY = 0.0f;
		CCAction *action = [CCSequence actions:
							[CCDelayTime actionWithDuration: delayTime],
							[CCScaleTo actionWithDuration:0.5F scale:1.0],
							nil];
		delayTime += 0.2f;
		[each runAction: action];
	}

	
	helpMenu.position = ccp(450, 30);
	[helpMenu alignItemsVerticallyWithPadding: 40.0f];
	[self addChild:helpMenu z: 2];

    
    CCSprite *bg = [CCSprite spriteWithFile: @"menubg.png"];
	bg.position = ccp(240,160);
	[self addChild: bg z:-1];
    
	return self;
}

- (void)onNewGame:(id)sender{
	[SceneManager goPlay];
}

- (void)onCredits:(id)sender{
	[SceneManager goCredits];
}
- (void)onHelp:(id)sender{
	[SceneManager goHelp];
}
@end
