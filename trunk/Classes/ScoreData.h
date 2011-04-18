//
//  ScoreData.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-04-17.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScoreData : NSObject {
    
    NSNumber* score;
    NSNumber* level;
}
@property ( retain, nonatomic ) NSNumber* score;
@property ( retain, nonatomic ) NSNumber* level;

@end
