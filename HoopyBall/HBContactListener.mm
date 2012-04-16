#import "cocos2d.h"
#import "Box2D.h"
#import "HBContactListener.h"
#import "HBUserData.h"
    


void HBContactListener::BeginContact(b2Contact* contact)

{ /* handle begin event */ }



void HBContactListener::EndContact(b2Contact* contact)

{
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
    b2Body* bodyB = contact->GetFixtureB()->GetBody();
    NSObject* dataObjectA = (NSObject*)bodyA->GetUserData();
    NSObject* dataObjectB = (NSObject*)bodyB->GetUserData();
    
    HBUserData* userDataA = (HBUserData*) dataObjectA;
    HBUserData* userDataB = (HBUserData*) dataObjectB;
    
    [userDataA handleCollisionBetween:bodyA with:userDataB];
    [userDataB handleCollisionBetween:bodyB with:userDataA];


}
