//
//  StarUserData.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"

#import "HBUserData.h"

@implementation StarUserData

-(void) handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody {
#if ALLOW_PLAYER_TO_WIN
    if(otherBody.nodeType == BALL_NODE_TYPE) {
        [[GameManager sharedInstance] handleWinLevel];
    }
#endif
}

-(int) nodeType {return STAR_NODE_TYPE;}

@end
