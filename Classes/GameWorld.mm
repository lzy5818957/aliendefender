//
//  GameWorld.mm
//  AlienDefense
//
//  Created by Zunyi Lin on 11-03-10.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "GameWorld.h"


@implementation GameWorld

@synthesize world, m_debugDraw, delegate, gameObjectReadyQueue, weaponArray, player, _contactListener,toBeRemovedArray,currentOnSceneArray;
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
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(emitEnemy) userInfo:nil repeats:YES];
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
	flags += b2DebugDraw::e_shapeBit;
	flags += b2DebugDraw::e_jointBit;
	flags += b2DebugDraw::e_aabbBit;
	flags += b2DebugDraw::e_pairBit;
	flags += b2DebugDraw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);
}

-(void)initBoundry
{
    boundry = [[ScreenBoundry alloc] init];
	[self realizeGameObject:boundry];
}

-(void)initPlayer
{
    player = [[[Player alloc] init] retain];
    
}

-(void)emitEnemy
{
    
    if([gameObjectReadyQueue count] != 0)
    {
        int r = arc4random() % [gameObjectReadyQueue count];
        
        if ([[gameObjectReadyQueue objectAtIndex:r] count] != 0) 
        {
            
        
            int c = arc4random() % [[gameObjectReadyQueue objectAtIndex:r] count];
    
            GameObject *gameObject = [[[gameObjectReadyQueue objectAtIndex:r] objectAtIndex:c] retain];
            [currentOnSceneArray addObject:gameObject];
            [self realizeGameObject:gameObject];
            [[gameObjectReadyQueue objectAtIndex:r] removeObject:gameObject];
            [gameObject release];
        }
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
        if (gameObject.type == TypePhysicalBullet) {
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

        /*
        switch (myActor.type) 
        {
            case TypeAlien:
                [myActor update];
                break;
                
            default:
                break;
        }
		*/	
	}
    
    [self emitWeapon];
	[self handleContact];
    [self cleanUpDeadGameObject];
	
}

-(void)handleContact
{
    
    std::vector<MyContact>::iterator pos;
	
	for(pos = _contactListener->_contacts.begin(); 
		pos != _contactListener->_contacts.end(); ++pos) 
	{
		MyContact contact = *pos;
        GameObject *fixtureAGameObject;
		GameObject *fixtureBGameObject;
        
		fixtureAGameObject = (GameObject *)(contact.fixtureA->GetUserData());
		fixtureBGameObject = (GameObject *)(contact.fixtureB->GetUserData());
        if (fixtureAGameObject != NULL && fixtureBGameObject != NULL) {
            if (
                (fixtureAGameObject.type == TypePhysicalBullet && fixtureBGameObject.type == TypeAlien )
                ||
                (fixtureAGameObject.type == TypeAlien  && fixtureBGameObject.type == TypePhysicalBullet)
                ) 
            {
                /*

				*/
                if(fixtureAGameObject.type == TypePhysicalBullet)
                {
                    [fixtureAGameObject setHealth:0];
                    [fixtureBGameObject damage:((PlayerWeaponObject*)fixtureAGameObject).attack];
                }
                else
                {
                    [fixtureBGameObject setHealth:0];
                    [fixtureAGameObject damage:((PlayerWeaponObject*)fixtureBGameObject).attack];
                }
				
				[fixtureBGameObject setToBeRemoved:YES];
				
            }
            if (
                (fixtureAGameObject.type == TypePhysicalBullet && fixtureBGameObject.type == TypeGroundBoundry )
                ||
                (fixtureAGameObject.type == TypeGroundBoundry  && fixtureBGameObject.type == TypePhysicalBullet)
                ) 
            {
                /*
                 
                 */
                if(fixtureAGameObject.type == TypePhysicalBullet)
                {
                    [fixtureAGameObject setToBeRemoved:YES];
                }
                else
                {
                    [fixtureBGameObject setToBeRemoved:YES];
                }
				
            }
        }
		

	}

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
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
