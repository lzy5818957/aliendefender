//
//  ScreenBoundry.m
//  AlienDefender
//
//  Created by Vincent on 11-3-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ScreenBoundryObject.h"


@implementation ScreenBoundryObject

-(id)init
{
    self = [super init];
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);

    return self;
}
@end
