#import "cocos2d.h"
#import "Box2D.h"

class HBContactListener : public b2ContactListener {
    
public:
    void BeginContact(b2Contact* contact);
    void EndContact(b2Contact* contact);
   

};