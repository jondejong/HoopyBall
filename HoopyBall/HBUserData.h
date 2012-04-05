//
//  HBUserData.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface HBUserData : CCNode {
    
}

#ifndef HB_USER_DATA_H
#define HB_USER_DATA_H

#define WALL_NODE_TYPE 1
#define BALL_NODE_TYPE 2
#define STAR_NODE_TYPE 3
#define BAD_GUY_NODE_TYPE 4

#endif

-(void) handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody;
-(int) nodeType;

@end

@interface WallUserData : HBUserData {}
-(NSArray *) sprites;
-(void) setSprites:(NSArray*)sprites;
@end

@interface BallUserData : HBUserData {} @end
@interface StarUserData : HBUserData {} @end
@interface BadGuyUserData : HBUserData {} @end
