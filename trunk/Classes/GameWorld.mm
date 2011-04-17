//
//  GameWorld.mm
//  AlienDefense
//
//  Created by Zunyi Lin on 11-03-10.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "GameWorld.h"
#import "SceneManager.h"

@implementation GameWorld

@synthesize world, m_debugDraw, delegate, gameObjectReadyQueue, weaponArray, player, _contactListener,
            toBeRemovedArray,currentOnSceneArray, boundry, exit, levelInTransition;
-(GameWorld *)init
{
	[super init];
	[self initWorld];
	[self initDebugMode];
	[self initBoundry];
    [self initPlayer];
	currentOnSceneArray = [[NSMutableArray arrayWithCapacity:0] retain];
	toBeRemovedArray = [[NSMutableArray arrayWithCapacity:0] retain];
    weaponArray = [[NSMutableArray arrayWithCapacity:0] retain];
    accumlator = 0;
    levelInTransition = NO;
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(emitEnemy) userInfo:nil repeats:YES];
    static uint r;
    r = 0;
	return self;
}

-(void)initWorld
{
	
	// Define the gravity vector.
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	
	// Do we want to let bodies sleep?
	// This will speed up the physics simulation
	bool doSleep = true;
	
	// Construct a world object, which will hold and simulate the rigid bodies.
	world = new b2World(gravity, doSleep);
	
	world->SetContinuousPhysics(true);
    
    // Create contact listener
    _contactListener = new MyContactListener();
    world->SetContactListener(_contactListener);

}

-(void)initDebugMode
{
	// Debug Draw functions
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	//flags += b2DebugDraw::e_shapeBit;
	//flags += b2DebugDraw::e_jointBit;
	//flags += b2DebugDraw::e_aabbBit;
	//flags += b2DebugDraw::e_pairBit;
	//flags += b2DebugDraw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
}

-(void)initBoundry
{
    boundry = [[Ground alloc] init];
    exit = [[Exit alloc] init];
    
	[self realizeGameObject:boundry];
    [self realizeGameObject:exit];
}

-(void)initPlayer
{
    player = [[[Player alloc] init] retain];
    ((Exit*)exit).delegate = player;
    
}

-(void)emitEnemy
{
    static uint r;
    
    //randomly take an enemy from ready queue and emit it
    if([gameObjectReadyQueue count] != 0)
    {

        if ([[gameObjectReadyQueue objectAtIndex:r] count] != 0) 
        {
            
        
            int c = arc4random() % [[gameObjectReadyQueue objectAtIndex:r] count];
    
            GameObject *gameObject = [[[gameObjectReadyQueue objectAtIndex:r] objectAtIndex:c] retain];
            [currentOnSceneArray addObject:gameObject];
            [self realizeGameObject:gameObject];
            [[gameObjectReadyQueue objectAtIndex:r] removeObject:gameObject];
            [gameObject release];
        }
        else
        {
            [gameObjectReadyQueue removeObjectAtIndex:r];
        }
        
        r += 1;
    }
    
    if (r >= [gameObjectReadyQueue count]) {
        r = 0;
    }
}

-(void)levelPassed
{
    if (levelInTransition) {
        
    
        PlayerData *playerData = [Resource PlayerData];
        playerData.currentLevel = [ NSNumber numberWithInt: [playerData.currentLevel intValue]+1];
        if ([playerData.currentLevel intValue] > [playerData.currentAvalibaleLevel intValue]) {
            playerData.currentAvalibaleLevel = [ NSNumber numberWithInt: [playerData.currentLevel intValue]];
        }
        [ [ CoreDataHelper sharedCoreDataHelper ] save ];
    
        [SceneManager goNextLevel];
    }

}

-(void)emitWeapon
{
    
    if([weaponArray count] != 0)
    {
        
                        
        PlayerWeaponObject *gameObject = [[weaponArray objectAtIndex:0] retain];
        [currentOnSceneArray addObject:gameObject];
        [self realizeGameObject:gameObject];
        [gameObject fire];
        [weaponArray removeObject:gameObject];
        [gameObject release];
        
    }
}
-(void)setUpPlayerWeapon
{

    [self realizeGameObject:[player cannon]];
    [self realizeGameObject:[player chargeBar]];
    [self realizeGameObject:[player playerLife]];
    [self realizeGameObject:[player coolDownBar]];

}
-(void)cleanUpDeadGameObject
{
    for (GameObject *gameObject in currentOnSceneArray) {
        
        if (gameObject.toBeRemoved == YES) {
            
            [toBeRemovedArray addObject:gameObject];
            [currentOnSceneArray removeObject:gameObject];
        }
    }

    for (GameObject *gameObject in toBeRemovedArray) {

        world->DestroyBody(gameObject.body);
        [delegate graphicalRemove:gameObject];
        if ([gameObject isKindOfClass:[PlayerWeaponObject class]]) {
            [gameObject release];
        }
    }
    [toBeRemovedArray release];
    toBeRemovedArray = [[NSMutableArray arrayWithCapacity:0] retain];
    
}

-(void)realizeGameObject:(GameObject*)gameObject
{
	[delegate graphicalRealize: gameObject];
	[self physicalRealize:gameObject];
    
    
}

-(void)physicalRealize:(GameObject*) gameObject
{
	
	[gameObject setBody:world->CreateBody(&(gameObject->bodyDef))];
    [gameObject setFixture:[gameObject body]->CreateFixture(&(gameObject->fixtureDef))];
    
}

-(void)update:(ccTime)dt
{
	accumlator += dt;
	//Iterate over the bodies in the physics world
	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
	{
        //Synchronize the AtlasSprites position and rotation with the corresponding body
        GameObject *myActor = ((GameObject*)b->GetUserData());
        
		[myActor update];

	}
    
    [self emitWeapon];
    [self cleanUpDeadGameObject];
    if ([gameObjectReadyQueue count] == 0 && [currentOnSceneArray count] == 0 && [toBeRemovedArray count] == 0 && levelInTransition == NO) 
    {
        levelInTransition = YES;
        [self levelPassed];
    }
	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [boundry release];
    [exit release];
	[gameObjectReadyQueue release];
	[currentOnSceneArray release];
	[toBeRemovedArray release];
	[player release];
	delete world;
	world = NULL;
    delete _contactListener;
	delete m_debugDraw;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
     
@end
