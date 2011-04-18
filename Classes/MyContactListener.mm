//
//  MyContactListener.mm
//  AlienDefense
//
//  Created by Zunyi Lin on 11-03-12.
//  Copyright 2011 University Of Saskatchewan. All rights reserved.
//

#import "MyContactListener.h"

MyContactListener::MyContactListener() : _contacts() {
}

MyContactListener::~MyContactListener() {
}

void MyContactListener::BeginContact(b2Contact* contact) {
    // We need to copy out the data because the b2Contact passed in
    // is reused.
    MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    _contacts.push_back(myContact);
}

void MyContactListener::EndContact(b2Contact* contact) {
    MyContact myContact = { contact->GetFixtureA(), contact->GetFixtureB() };
    std::vector<MyContact>::iterator pos;
    pos = std::find(_contacts.begin(), _contacts.end(), myContact);
    if (pos != _contacts.end()) {
        _contacts.erase(pos);
    }
}

void MyContactListener::PreSolve(b2Contact* contact, 
								 const b2Manifold* oldManifold) {
    GameObject *fixtureAGameObject;
    GameObject *fixtureBGameObject;
    
    fixtureAGameObject = (GameObject *)(contact->GetFixtureA()->GetUserData());
    fixtureBGameObject = (GameObject *)(contact->GetFixtureB()->GetUserData());
    if (fixtureAGameObject != NULL && fixtureBGameObject != NULL) {
        
        //Weapon vs Enemy
        if (
            ([fixtureAGameObject isKindOfClass:[PlayerWeaponObject class]] && [fixtureBGameObject isKindOfClass:[EnemyObject class]] )
            ||
            ([fixtureAGameObject isKindOfClass:[EnemyObject class]] && [fixtureBGameObject isKindOfClass:[PlayerWeaponObject class]])
            ) 
        {
            [Resource addScore:50];
            if ([fixtureAGameObject isKindOfClass:[PlayerWeaponObject class]])
            {
                ((PlayerWeaponObject*)fixtureAGameObject).age += 80;
                [fixtureBGameObject damage:((PlayerWeaponObject*)fixtureAGameObject).attack];
            }
            else
            {
                ((PlayerWeaponObject*)fixtureBGameObject).age += 80;
                [fixtureAGameObject damage:((PlayerWeaponObject*)fixtureBGameObject).attack];
                
            }
            
            
        }
        
        //Weapon vs Ground
        if (
            ([fixtureAGameObject isKindOfClass:[PlayerWeaponObject class]] && [fixtureBGameObject isKindOfClass:[ScreenBoundryObject class]] )
            ||
            ([fixtureAGameObject isKindOfClass:[ScreenBoundryObject class]] && [fixtureBGameObject isKindOfClass:[PlayerWeaponObject class]])
            ) 
        {

            if([fixtureAGameObject isKindOfClass:[PlayerWeaponObject class]])
            {
                [fixtureAGameObject setToBeRemoved:YES];
            }
            else
            {
                [fixtureBGameObject setToBeRemoved:YES];
            }
            
        }
        
        //Exit vs Enemy
        if (
            ([fixtureAGameObject isKindOfClass:[EnemyObject class]] && [fixtureBGameObject isKindOfClass:[Exit class]] )
            ||
            ([fixtureAGameObject isKindOfClass:[Exit class]] && [fixtureBGameObject isKindOfClass:[EnemyObject class]])
            ) 
        {
            
            if([fixtureAGameObject isKindOfClass:[EnemyObject class]])
            {
                [((Exit*)fixtureBGameObject) enemyDidPassExit];
                [fixtureAGameObject setToBeRemoved:YES];
                
            }
            else
            {
                [((Exit*)fixtureAGameObject) enemyDidPassExit];
                [fixtureBGameObject setToBeRemoved:YES];
            }
            
        }
        
        //FlyingEnemy vs GroundEnemy
        if (
            ([fixtureAGameObject isKindOfClass:[FlyingEnemyObject class]] && [fixtureBGameObject isKindOfClass:[GroundEnemyObject class]] )
            ||
            ([fixtureAGameObject isKindOfClass:[GroundEnemyObject class]] && [fixtureBGameObject isKindOfClass:[FlyingEnemyObject class]])
            ) 
        {
            
            if([fixtureAGameObject isKindOfClass:[FlyingEnemyObject class]])
            {
                [fixtureAGameObject setToBeRemoved:YES];
                [fixtureBGameObject setToBeRemoved:YES];
                
            }
            else
            {
                [fixtureAGameObject setToBeRemoved:YES];
                [fixtureBGameObject setToBeRemoved:YES];
            }
            [Resource addScore:200];
        }
        
        //FlyingEnemy vs Ground
        if (
            ([fixtureAGameObject isKindOfClass:[FlyingEnemyObject class]] && [fixtureBGameObject isKindOfClass:[ScreenBoundryObject class]] )
            ||
            ([fixtureAGameObject isKindOfClass:[ScreenBoundryObject class]] && [fixtureBGameObject isKindOfClass:[FlyingEnemyObject class]])
            ) 
        {
            
            if([fixtureAGameObject isKindOfClass:[FlyingEnemyObject class]])
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

void MyContactListener::PostSolve(b2Contact* contact, 
								  const b2ContactImpulse* impulse) {
}

