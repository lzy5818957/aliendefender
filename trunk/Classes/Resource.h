//
//  Resource.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-24.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerData.h"
#import "PlayerData.h"
#import "CoreDataHelper.h"
#import "ScoreData.h"

@interface Resource : NSObject {

}
+(CGPoint)AcceValue;
+(void)SetAcceValue:(CGPoint)acceValue;
+(PlayerData*)PlayerData;
+(ScoreData*)ScoreData: (NSNumber*) level;
+(void)addScore:(int)value;
+(void)saveScore;
+(NSMutableDictionary*)TextureDictionary;
+(int*)Score;
-(void)releaseTexture;
@end
