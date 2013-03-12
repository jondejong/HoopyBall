//
//  WallCollisionHandler.m
//  ;
//
//  Created by Jonathan DeJong on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"
#import "HBUserData.h"
#import "cocos2d.h"

@implementation WallUserData {

@private
    b2Body* _body;
    
    // Make sure if this wall has already had it's body deleted, that we don't mark it again.
    bool deleted;

}

@synthesize sprites;

- (id)init
{
    self = [super init];
    if (self) {
        deleted = false;
    }
    return self;
}

-(void)handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody {
    
#if WALLS_BREAK
    if(otherBody.nodeType == BALL_NODE_TYPE || otherBody.nodeType == ENEMY_NODE_TYPE) {
        [self removeThisWall];
    }
#endif
}

-(void) removeThisWall {
    if(!deleted) {
        [[GameManager sharedInstance] markBodyForDeletion: _body];
        deleted = true;
    }
    for(CCSprite * sprite in sprites) {
        [[GameManager sharedInstance] removeSpriteFromGame:sprite];
    }
}

-(int) nodeType {
    return WALL_NODE_TYPE;
}

-(void) setBody : (b2Body*) body {
    _body = body;
}

- (void)dealloc{
    [sprites release];
    sprites = nil;
    [super dealloc];
}

@end
