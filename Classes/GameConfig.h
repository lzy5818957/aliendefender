//
//  GameConfig.h
//  AlienDefender
//
//  Created by Zunyi Lin on 11-03-14.
//  Copyright University Of Saskatchewan 2011. All rights reserved.
//

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

//
// Define here the type of autorotation that you want for your game
//
#define GAME_AUTOROTATION kGameAutorotationNone

//pixel per meter
#define PTM_RATIO 32

#endif // __GAME_CONFIG_H