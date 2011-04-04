//
//  Resource.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-24.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Resource : NSObject {

}
+(CGPoint)AcceValue;
+(void)SetAcceValue:(CGPoint)acceValue;
+(NSMutableDictionary*)TextureDictionary;
-(void)releaseTexture;
@end
