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
//    CCSprite * sprite;
}


//-(id) initWithBody: (b2Body*)_body andSprite: _sprite inWorld: (b2World*)_world {
-(id) initWithBody: (b2Body*)_body {
    if(self = [super init]) {
        body = _body;
//        sprite = _sprite;
    }
    return self;
}

-(b2Body*) body {
    return body;
}



//-(CCSprite*) sprite {
//    return sprite;
//}

- (void)dealloc
{
    body = nil;
    [super dealloc];
}

@end
