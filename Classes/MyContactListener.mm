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
        
        //Physical Bullet vs Alien
        if (
            (fixtureAGameObject.type == TypePhysicalBullet && fixtureBGameObject.type == TypeAlien )
            ||
            (fixtureAGameObject.type == TypeAlien  && fixtureBGameObject.type == TypePhysicalBullet)
            ) 
        {

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
            
            
        }
        //Physical Bullet vs UFO
        if (
            (fixtureAGameObject.type == TypePhysicalBullet && fixtureBGameObject.type == TypeUFO )
            ||
            (fixtureAGameObject.type == TypeUFO  && fixtureBGameObject.type == TypePhysicalBullet)
            ) 
        {
            
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
            
            
        }
        //Physical Bullet vs Ground
        if (
            (fixtureAGameObject.type == TypePhysicalBullet && fixtureBGameObject.type == TypeGround )
            ||
            (fixtureAGameObject.type == TypeGround  && fixtureBGameObject.type == TypePhysicalBullet)
            ) 
        {

            if(fixtureAGameObject.type == TypePhysicalBullet)
            {
                [fixtureAGameObject setToBeRemoved:YES];
            }
            else
            {
                [fixtureBGameObject setToBeRemoved:YES];
            }
            
        }
        
        //Exit vs Alien
        if (
            (fixtureAGameObject.type == TypeAlien && fixtureBGameObject.type == TypeExit )
            ||
            (fixtureAGameObject.type == TypeExit  && fixtureBGameObject.type == TypeAlien)
            ) 
        {
            
            if(fixtureAGameObject.type == TypeAlien)
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
        
        //Exit vs UFO
        if (
            (fixtureAGameObject.type == TypeUFO && fixtureBGameObject.type == TypeExit )
            ||
            (fixtureAGameObject.type == TypeExit  && fixtureBGameObject.type == TypeUFO)
            ) 
        {
            
            if(fixtureAGameObject.type == TypeUFO)
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
    }
    
}

void MyContactListener::PostSolve(b2Contact* contact, 
								  const b2ContactImpulse* impulse) {
}

