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
    
    if(otherBody.nodeType == BALL_NODE_TYPE || otherBody.nodeType == BAD_GUY_NODE_TYPE) {
        [[GameManager sharedInstance] markBodyForDeletion: thisBody];
        for(CCSprite * sprite in sprites) {
            [[GameManager sharedInstance] removeSpriteFromGame:sprite];
        }
    }
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
