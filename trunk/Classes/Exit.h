//
//  Exit.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-23.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScreenBoundryObject.h"

@protocol ExitDelegate 

@required
-(void)playerLoseALife;
@end

@interface Exit : ScreenBoundryObject {
    
    id <ExitDelegate> delegate;
}

@property (nonatomic, retain) id <ExitDelegate> delegate;

-(void)enemyDidPassExit;
@end
