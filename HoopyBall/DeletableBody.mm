//
//  DeletableBody.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DeletableBody.h"
#import "Box2D.h"

@implementation DeletableBody {

    @private
    b2Body* body;
    b2World* world;
//    CCSprite * sprite;
}


//-(id) initWithBody: (b2Body*)_body andSprite: _sprite inWorld: (b2World*)_world {
-(id) initWithBody: (b2Body*)_body inWorld: (b2World*)_world {
    if(self = [super init]) {
        body = _body;
        world = _world;
//        sprite = _sprite;
    }
    return self;
}

-(b2Body*) body {
    return body;
}

-(b2World*) world {
    return world;
}

//-(CCSprite*) sprite {
//    return sprite;
//}

- (void)dealloc
{
    body = nil;
    world = nil;
    [super dealloc];
}

@end
