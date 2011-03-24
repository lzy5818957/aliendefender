//
//  GameScene.m
//  AlienDefense
//
//  Created by Zunyi Lin on 11-03-09.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "GameScene.h"



@implementation GameScene

@synthesize gameWorld, level,ltouchStartTime, weaponDirection;

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
		
		// enable touches
		self.isTouchEnabled = YES;
		
		// enable accelerometer
		self.isAccelerometerEnabled = NO;
		
		//set background color
		//[self addChild:[CCColorLayer layerWithColor:ccc4(255, 255, 255, 255)]];
		
        //initWeaponDirection
        weaponDirection = CGPointMake(1, 0);
		angle = 0.f;
		//init GameWorld
		gameWorld = [[GameWorld alloc] init];
		[gameWorld setDelegate:self];

		level = [[LevelObject levelWithLevelNumber:1] retain];
		NSMutableArray *wavesOfGameObjectArray = [level generateGameObject];
        [gameWorld setUpPlayerWeapon];
		[gameWorld setGameObjectReadyQueue: wavesOfGameObjectArray];
		
		[self schedule: @selector(tick:)];
	}
	return self;
}



//delegate method
-(void)graphicalRealize:(GameObject*)gameObject
{
	[self addChild: gameObject.sprite];

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
    

}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
        
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        if (location.x<=[CCDirector sharedDirector].winSize.width/2) {
            // When the touch event was detected
            ltouchStartTime = [event timestamp];
        }
        else
        {
            rTouchStartLocation = [touch locationInView:[touch view]];
        }
       

        
	}
    // <--this gets all the current touches
    NSSet *allTouches = [event allTouches];  
     //iterate through all the touches
	for (UITouch *touch in allTouches) { 

	//	CCLOG(@"X: %f, Y: %f",[touch previousLocationInView:touch.view].x,[touch previousLocationInView:touch.view].y); 
        
	}
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{

    for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        if (location.x<=[CCDirector sharedDirector].winSize.width/2) {

        }
        else
        {
            //transform the body according to y coord changes
            angle = M_PI*([touch locationInView:[touch view]].x - [touch previousLocationInView:[touch view]].x)/180 + angle;
            b2Vec2 pos = gameWorld.player.cannon.body->GetPosition();
            gameWorld.player.cannon.body->SetTransform(pos, angle);
            
        }
    }

}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    // Calculate how long touch lasted
    NSTimeInterval touchTimeDuration;
    
    //NSLog(@"Touch duration: %3.2f seconds", touchTimeDuration);
    
    for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        if (location.x<=[CCDirector sharedDirector].winSize.width/2) {
            touchTimeDuration = [event timestamp] - ltouchStartTime;
            //fire weapon
            PlayerWeaponObject *weapon = [gameWorld.player loadWeaponCharge:touchTimeDuration*5  Direction:weaponDirection];
            [[gameWorld weaponArray] addObject:weapon];
        }
        else
        {

            //  We find the vector to do a hit detection based on the percentage
            //  We know the first vector is the one @ 12 o'clock (top,mid) so we rotate
            //  from that by the progress angle around the midpoint pivot
            weaponDirection = ccpForAngle(angle);
        }
    
        

	}
    /*
    // <--this gets all the current touches
    NSSet *allTouches = [event allTouches]; 
    //iterate through all the touches
   
	for (UITouch *touch in allTouches) { 
        
    //CCLOG(@"X: %f, Y: %f",[touch previousLocationInView:touch.view].x,[touch previousLocationInView:touch.view].y); 
        
	}
    */


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
