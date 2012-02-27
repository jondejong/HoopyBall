//
//  WallCollisionHandler.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WallCollisionHandler.h"
#import "GameScene.h"


@implementation WallCollisionHandler {
    
    @private
    b2Body* body;
    b2World* world;
    CCSprite* sprite;
}

-(id) initWithWorld:(b2World*) _world andBody:(b2Body*)_body andSprite: (CCSprite*)_sprite{
    if(self = [super init]) {
        body = _body;
        world = _world;
        sprite = _sprite;
    }
    return self;
}

-(void) handleCollision{
    [[GameScene sharedInstance] markBodyForDeletion:body andSprite: sprite inWorld:world];
}

- (void)dealloc
{
    body = nil;
    world = nil;
    [super dealloc];
}

@end
