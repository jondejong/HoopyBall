#import "cocos2d.h"
#import "Box2D.h"
#import "WallContactListener.h"
#import "WallCollisionHandler.h"
    


void WallContactListener::BeginContact(b2Contact* contact)

{ /* handle begin event */ }



void WallContactListener::EndContact(b2Contact* contact)

{
    NSObject* userDataA = (NSObject*)contact->GetFixtureA()->GetUserData();
    NSObject* userDataB = (NSObject*)contact->GetFixtureB()->GetUserData();
    
    if(userDataA != nil) {
        if([userDataA isKindOfClass:[HBUserData class]]) {
            [(HBUserData*)userDataA handleCollision];
        }
    }
    
    if(userDataB != nil) {
        if([userDataB isKindOfClass:[HBUserData class]]) {
            [(HBUserData*)userDataB handleCollision];
        }
    }
}
