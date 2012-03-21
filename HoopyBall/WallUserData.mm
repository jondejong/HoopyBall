//
//  WallCollisionHandler.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "GamePlayRootNode.h"
#import "GameManager.h"
#import "HBUserData.h"

@implementation WallUserData {}
    


-(void)handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody {
    
    if(otherBody.nodeType == BALL_NODE_TYPE) {
        [[GameManager sharedInstance] markBodyForDeletion: thisBody];
    }
}

-(int) nodeType {
    return WALL_NODE_TYPE;
}

- (void)dealloc{
    [super dealloc];
}

@end
