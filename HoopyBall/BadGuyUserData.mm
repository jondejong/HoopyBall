//
//  BadGuyUserData.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "HoopyBall.h"
#import "HBUserData.h"

@implementation BadGuyUserData

-(void) handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody{

    if([otherBody nodeType] == BALL_NODE_TYPE) {
        [[GameManager sharedInstance] handleLoseLevel];
    }
    
}

-(int) nodeType { return BAD_GUY_NODE_TYPE;}

@end
