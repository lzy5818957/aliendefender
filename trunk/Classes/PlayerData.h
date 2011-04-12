//
//  PlayerData.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-07.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlayerData : NSObject {
    
    NSNumber* currentLevel;
    NSNumber* currentAvalibaleLevel;
}
@property ( retain, nonatomic ) NSNumber* currentLevel;
@property ( retain, nonatomic ) NSNumber* currentAvalibaleLevel;
@end
