#import "Box2D.h"
#import "cocos2d.h"
#import <vector>
#import <algorithm>

#import "GameObject.h"
#import "ScreenBoundryObject.h"
#import "PlayerWeaponObject.h"
#import "EnemyObject.h"
#import "Ground.h"
#import "Exit.h"
#import "FlyingEnemyObject.h"
#import "GroundEnemyObject.h"
#import "Resource.h"
struct MyContact {
    b2Fixture *fixtureA;
    b2Fixture *fixtureB;
    bool operator==(const MyContact& other) const
    {
        return (fixtureA == other.fixtureA) && (fixtureB == other.fixtureB);
    }
};

class MyContactListener : public b2ContactListener {
	
public:
    std::vector<MyContact>_contacts;
	
    MyContactListener();
    ~MyContactListener();
	
    virtual void BeginContact(b2Contact* contact);
    virtual void EndContact(b2Contact* contact);
    virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);    
    virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
	
};