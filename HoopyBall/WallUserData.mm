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
}
    
@synthesize sprites;

-(void)handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody {
    
#if WALLS_BREAK
    if(otherBody.nodeType == BALL_NODE_TYPE || otherBody.nodeType == ENEMY_NODE_TYPE) {
        [[GameManager sharedInstance] markBodyForDeletion: thisBody];
        for(CCSprite * sprite in sprites) {
            [[GameManager sharedInstance] removeSpriteFromGame:sprite];
        }
    }
#endif
}

-(int) nodeType {
    return WALL_NODE_TYPE;
}

- (void)dealloc{
    [sprites release];
    sprites = nil;
    [super dealloc];
}

@end
