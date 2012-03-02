//
//  DeletableBody.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface DeletableBody : NSObject{
    
}

//-(id) initWithBody: (b2Body*)_body andSprite: (CCSprite*) _sprite inWorld: (b2World*) _world;
-(id) initWithBody: (b2Body*)_body inWorld: (b2World*) _world;
-(b2Body*) body;
-(b2World*) world;
//-(CCSprite*) sprite;

@end
