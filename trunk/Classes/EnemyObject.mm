//
//  EnemyObject.m
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "EnemyObject.h"


@implementation EnemyObject
@synthesize speed;

-(id)init
{
    self = [super init];

    return self;
}

- (void) dealloc
{
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
