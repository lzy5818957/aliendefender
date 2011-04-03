//
//  MenuLayer.m
//  MenuLayer
//
//  Created by MajorTom on 9/7/10.
//  Copyright iphonegametutorials.com 2010. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

-(id) init{
	self = [super init];
		
	float delayTime = 0.3f;
	
	CCMenuItemImage *startNew = [CCMenuItemImage itemFromNormalImage:@"newGameBtn.png" selectedImage:@"newGameBtn_over.png" target:self selector:@selector(onNewGame:)];

	CCMenuItemImage *credits = [CCMenuItemImage itemFromNormalImage:@"creditsBtn.png" selectedImage:@"creditsBtn_over.png" target:self selector:@selector(onCredits:)];
	
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
	
    CCSprite *bg = [CCSprite spriteWithFile: @"background.png"];
	bg.position = ccp(240,160);
	[self addChild: bg z:0];
    
	return self;
}

- (void)onNewGame:(id)sender{
	[SceneManager goPlay];
}

- (void)onCredits:(id)sender{
	[SceneManager goCredits];
}
@end
