//
//  BaseLayer.m
//  BaseLayer
//
//  Created by MajorTom on 9/7/10.
//  Copyright iphonegametutorials.com 2010. All rights reserved.
//

#import "BaseScene.h"

@implementation BaseScene
-(id) init{
	self = [super init];
	if(nil == self){
		return nil;
	}
	
    // enable touches
    self.isTouchEnabled = YES;
    
    // enable accelerometer
    self.isAccelerometerEnabled = YES;
	
	//CCSprite *bg = [CCSprite spriteWithFile: @"background.png"];
	//bg.position = ccp(160,240);
	//[self addChild: bg z:0];
	
	
	return self;
}
@end
