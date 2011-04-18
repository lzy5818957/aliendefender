//
//  GameScene.m
//  AlienDefense
//
//  Created by Zunyi Lin on 11-03-09.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "GameScene.h"



@implementation GameScene

@synthesize gameWorld, level, weaponDirection;

#define ktagGameMenu 0
#define ktagPauseBG 1
#define ktagPlayBtn 2
#define ktagPauseMenu 3
#define ktagDirectionBtn 4
#define ktagScoreLabel 5
#define ktagShootBtn 10
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


// initialize your instance here
-(id) init
{
	if( (self=[super init])) {
		

		
		//set background color
		//[self addChild:[CCColorLayer layerWithColor:ccc4(255, 255, 255, 255)]];
		
        //initWeaponDirection
        weaponDirection = CGPointMake(1, 0);
		angle = 0.f;
        chargeTimer = 0;
        chargeStart = NO;
        
		//init GameWorld
		gameWorld = [[GameWorld alloc] init];
		[gameWorld setDelegate:self];
        
        
		level = [[LevelObject levelWithLevelNumber:[[Resource PlayerData].currentLevel intValue]] retain];
		NSMutableArray *wavesOfGameObjectArray = [level generateGameObject];
        [gameWorld setUpPlayerWeapon];
		[gameWorld setGameObjectReadyQueue: wavesOfGameObjectArray];
		
        
		[self schedule: @selector(tick:)];
        
        //setup sprites
        CCSprite *bg = [CCSprite spriteWithFile: @"gamebg.jpg"];
        bg.position = ccp(240,160);
        [self addChild: bg z:-1];
        
        
        CCMenuItemImage *pause = [CCMenuItemImage  itemFromNormalImage:@"pauseBtn.png" selectedImage:@"pauseBtn_over.png" target:self selector:@selector(pause:)];
        pause.position = ccp(15,305);
        
        CCMenuItemImage *changeWeapon = [CCMenuItemImage  itemFromNormalImage:@"changeWeaponBtn.png" selectedImage:@"changeWeaponBtn_over.png" target:self selector:@selector(changeWeapon:)];
        changeWeapon.position = ccp(240,300);
        
        CCMenuItemImage *shoot;
        if(gameWorld.player.currentWeaponType == [PhysicalBullet class])
        {
            shoot = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"physicalBulletBtn"]]
                                           selectedSprite:[CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"physicalBulletBtn_over"]]
                                                   target:self 
                                                 selector:@selector(shoot:)];
        }
        else if(gameWorld.player.currentWeaponType == [ControllableBullet class])
        {
            shoot = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"controllableBulletBtn"]]
                                           selectedSprite:[CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"controllableBulletBtn_over"]]
                                                   target:self 
                                                 selector:@selector(shoot:)];
        }
        shoot.position = ccp(40,80);
        shoot.tag = ktagShootBtn;
        
        CCMenu *menu = [CCMenu menuWithItems: pause, changeWeapon, shoot,nil];
        menu.position = ccp(0, 0);
        [self addChild: menu z:1 tag:ktagGameMenu];
        
        CCSprite *directionBtn = [CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"DirectionBtn"]];
        directionBtn.position = CGPointMake(410, 160);
        directionBtn.opacity = 200.0f;
        [self addChild: directionBtn z:1 tag:ktagDirectionBtn];
        
        int *score = [Resource Score];
        (*score) = 0;
        [((ScoreData*)[Resource ScoreData: [[Resource PlayerData] currentLevel]]).score intValue];
        NSString *scoreString = [NSString stringWithFormat:@"%d",(*score)];
        CCLabelBMFont *scoreLabel = [CCLabelBMFont labelWithString:scoreString fntFile:@"scoreFont.fnt"];
        [scoreLabel setAnchorPoint:CGPointMake(0.0f, 0.0f)];
        [scoreLabel setPosition:ccp(5, 260)];
        [self addChild:scoreLabel z: 1 tag:ktagScoreLabel];
        
	}
    

    return self;
}

-(void) pause: (id) sender{
    

    
    CCSprite *pauseScreen = [CCSprite spriteWithFile: @"pausebg.png"];
    pauseScreen.position = ccp(240,160);
    [self addChild: pauseScreen z:2 tag:ktagPauseBG];
    
    CCMenuItemImage *play = [CCMenuItemImage  itemFromNormalImage:@"playBtn.png" selectedImage:@"playBtn_over.png" target:self selector:@selector(play:)];
	CCMenu *menu = [CCMenu menuWithItems: play, nil];
	
	menu.position = ccp(15, 305);
	[self addChild: menu z:3 tag:ktagPlayBtn];
    
    //Pause menu
    CCMenuItemFont *resume = [CCMenuItemFont itemFromString:@"RESUME" target:self selector: @selector(play:)];
    CCMenuItemFont *mainMenu = [CCMenuItemFont itemFromString:@"MAIN MENU" target:self selector: @selector(back:)];

	CCMenu *pauseMenu = [CCMenu menuWithItems:resume, mainMenu, nil];
    
    [self addChild: pauseMenu z:3 tag:ktagPauseMenu];
    pauseMenu.position = ccp(240, 160);
	[pauseMenu alignItemsVerticallyWithPadding: 40.0f];
    
	[[CCDirector sharedDirector] pause];
}

-(void) changeWeapon: (id) sender{
    
    [gameWorld.player changeWeapon];
    CCMenuItemImage *shootBtn = (CCMenuItemImage*)[(CCMenu*)[self getChildByTag:ktagGameMenu] getChildByTag:ktagShootBtn];
    if(gameWorld.player.currentWeaponType == [PhysicalBullet class])
    {
        [shootBtn setNormalImage:[CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"physicalBulletBtn"]]];
        [shootBtn setSelectedImage:[CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"physicalBulletBtn_over"]]];
    }
    else if(gameWorld.player.currentWeaponType == [ControllableBullet class])
    {
        [shootBtn setNormalImage:[CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"controllableBulletBtn"]]];
        [shootBtn setSelectedImage:[CCSprite spriteWithTexture:[[Resource TextureDictionary] valueForKey:@"controllableBulletBtn_over"]]];
    }
    
}

-(void) play: (id) sender{
    
    [self removeChildByTag:ktagPauseBG cleanup:YES];
    [self removeChildByTag:ktagPlayBtn cleanup:YES];
    [self removeChildByTag:ktagPauseMenu cleanup:YES];
    
	[[CCDirector sharedDirector] resume];
}

-(void) back: (id) sender{
    

	[[CCDirector sharedDirector] resume];
	[SceneManager goMenu];
}

- (void)shoot: (id) sender
{
    //fire weapon
    if(gameWorld.player.coolDownBar.isAvaliable == YES)
    {
        PlayerWeaponObject *weapon = [gameWorld.player loadWeaponCharge:gameWorld.player.chargeBar.charge*4
                                                          Direction:weaponDirection];
        chargeTimer = 0;
        chargeStart = NO;
        [[gameWorld weaponArray] addObject:weapon];
        
        [gameWorld.player.coolDownBar resetTimer:weapon.rechargeTime];
        
    }
    else
    {
        

    }

    
}

//delegate method
-(void)graphicalRealize:(GameObject*)gameObject
{
	[self addChild: gameObject.sprite z:2];

}

-(void)graphicalRemove:(GameObject*)gameObject
{

    [self removeChild:gameObject.sprite cleanup:true];
    
}
-(void) draw
{
	// Default GL states: GL_TEXTURE_2D, GL_VERTEX_ARRAY, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	// Needed states:  GL_VERTEX_ARRAY, 
	// Unneeded states: GL_TEXTURE_2D, GL_COLOR_ARRAY, GL_TEXTURE_COORD_ARRAY
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	
	gameWorld.world->DrawDebugData();
	
	// restore default GL states
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
}


-(void) tick: (ccTime) dt
{

	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	gameWorld.world->Step(dt, velocityIterations, positionIterations);

	[gameWorld update:dt];
    // Calculate how long touch lasted
    
    if(chargeStart == YES)
    {
        chargeTimer += 0.05;

    }
    CCMenu *gameMenu = (CCMenu*)[self getChildByTag:ktagGameMenu];
    CCMenuItem *shootBtn = (CCMenuItem*)[gameMenu getChildByTag:ktagShootBtn];
    
    if (shootBtn.isSelected == YES && gameWorld.player.coolDownBar.isAvaliable == YES) {
        chargeStart = YES;
        
    }
    
    gameWorld.player.chargeBar.charge = chargeTimer;
    
    [((CCLabelBMFont*)[self getChildByTag:ktagScoreLabel]) setString: [NSString stringWithFormat:@"%d", *[Resource Score]]];
    
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {

		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        if (location.x<=[CCDirector sharedDirector].winSize.width*3/4 && location.y<=[CCDirector sharedDirector].winSize.height*2/3) {
            
            
        }
        else if (location.x<=[CCDirector sharedDirector].winSize.width*3/4 && location.y>=[CCDirector sharedDirector].winSize.height*2/3) {

        }
        else
        {
            
            rTouchStartLocation = [touch locationInView:[touch view]];
            CCSprite *directionBtn =(CCSprite*)[self getChildByTag:ktagDirectionBtn];
            
            directionBtn.opacity = 100;
            
            
        }


	}
    
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{


    for( UITouch *touch in touches ) {

        CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        if (location.x<=[CCDirector sharedDirector].winSize.width*3/4 && location.y<=[CCDirector sharedDirector].winSize.height*2/3) {

            
        }
        else if (location.x<=[CCDirector sharedDirector].winSize.width*3/4 && location.y>=[CCDirector sharedDirector].winSize.height*2/3) {

        }
        else
        {
            //transform the body according to y coord changes
            angle = M_PI*([touch locationInView:[touch view]].x - [touch previousLocationInView:[touch view]].x)/180 + angle;
            b2Vec2 pos = gameWorld.player.cannon.body->GetPosition();
            gameWorld.player.cannon.body->SetTransform(pos, angle);
            
            //Radius to CGPoint 
            weaponDirection = ccpForAngle(angle);
            
        }
        

    }
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{

    
    //NSLog(@"Touch duration: %3.2f seconds", touchTimeDuration);
    
    for( UITouch *touch in touches ) {

        CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        if (location.x<=[CCDirector sharedDirector].winSize.width*3/4 && location.y<=[CCDirector sharedDirector].winSize.height*2/3) {

            
        }
        else if (location.x<=[CCDirector sharedDirector].winSize.width*3/4 && location.y>=[CCDirector sharedDirector].winSize.height*2/3) {

            if (gameWorld.player.currentWeaponType == [PhysicalBullet class]) {
                gameWorld.player.currentWeaponType = [ControllableBullet class];
            }
            else
            {
                gameWorld.player.currentWeaponType = [PhysicalBullet class];
            }
            
        }

        else
        {
            rTouchStartLocation = [touch locationInView:[touch view]];
            CCSprite *directionBtn =(CCSprite*)[self getChildByTag:ktagDirectionBtn];
            
            directionBtn.opacity = 40.0f;
        }


	}

}


- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{	
	static float prevX=0, prevY=0;
	
	//#define kFilterFactor 0.05f
#define kFilterFactor 1.0f	// don't use filter. the code is here just as an example
	
	float accelX = (float) acceleration.x * kFilterFactor + (1- kFilterFactor)*prevX;
	float accelY = (float) acceleration.y * kFilterFactor + (1- kFilterFactor)*prevY;
	
	prevX = accelX;
	prevY = accelY;
	
	// accelerometer values are in "Portrait" mode. Change them to Landscape left
	// multiply the gravity by 10
	//b2Vec2 gravity( -accelY * 10, accelX * 10);
	//gameWorld.world->SetGravity( gravity );
    
    [Resource SetAcceValue:CGPointMake(-accelY, accelX)];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	
	[gameWorld release];
	[level release];
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
