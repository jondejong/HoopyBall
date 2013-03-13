#import "cocos2d.h"
#import "Box2D.h"
#import "HBContactListener.h"
#import "HBUserData.h"
    


void HBContactListener::BeginContact(b2Contact* contact) { 
    b2Body* bodyA = contact->GetFixtureA()->GetBody();
    b2Body* bodyB = contact->GetFixtureB()->GetBody();
    NSObject* dataObjectA = (__bridge NSObject*)bodyA->GetUserData();
    NSObject* dataObjectB = (__bridge NSObject*)bodyB->GetUserData();
    
    HBUserData* userDataA = (HBUserData*) dataObjectA;
    HBUserData* userDataB = (HBUserData*) dataObjectB;
    
    [userDataA handleCollisionBetween:bodyA with:userDataB];
    [userDataB handleCollisionBetween:bodyB with:userDataA];

}



void HBContactListener::EndContact(b2Contact* contact) {


}
