//
//  EnemyUserData.mm
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "HoopyBall.h"
#import "HBUserData.h"

@implementation EnemyUserData

-(void) handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody{

#if ENEMIES_KILL
    if([otherBody nodeType] == BALL_NODE_TYPE) {
        [[GameManager sharedInstance] handleLoseLevel];
    }
#endif
}

-(int) nodeType { return ENEMY_NODE_TYPE;}

@end
