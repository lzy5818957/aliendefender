//
//  CreditsLayer.m
//  CreditsLayer
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "LevelScene.h"

@implementation LevelScene
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
    
    //arrange level button
    int x = 20;
    int y = 280;
    
    for (int i = 1; i <= [[Resource PlayerData].currentAvalibaleLevel intValue];  i++) {
        int score = [((ScoreData*)[Resource ScoreData: [NSNumber numberWithInt:i]]).score intValue];
        CCMenuItemFont *item = [CCMenuItemFont itemFromString:[NSString stringWithFormat:@"Level%d Score:%d", i ,score] 
                                                       target:self 
                                                     selector:@selector(onLevelNumber:)];
        item.anchorPoint = CGPointMake(0.0f, 0.0f);
        item.tag = i;
        item.position = CGPointMake(x, y);
        

        y -= 50;
        
        
        [menu addChild:item];
    }
	
    CCSprite *bg = [CCSprite spriteWithFile: @"menubg.png"];
	bg.position = ccp(240,160);
	[self addChild: bg z:-1];
    
	return self;
}


-(void) onLevelNumber: (id) sender{
    

    PlayerData *playerData = [Resource PlayerData];
    playerData.currentLevel = [ NSNumber numberWithInt: ((CCMenuItemFont*)sender).tag ];
    [ [ CoreDataHelper sharedCoreDataHelper ] save ];
    [SceneManager goPlay];

}

-(void) back: (id) sender{
	[SceneManager goMenu];
}

@end
