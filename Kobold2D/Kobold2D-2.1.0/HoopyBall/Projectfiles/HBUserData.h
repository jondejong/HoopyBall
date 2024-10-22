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
#define ENEMY_NODE_TYPE 4
#define COIN_NODE_TYPE 5

#endif

-(void) handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody;
-(int) nodeType;

@end

@interface WallUserData : HBUserData {}
@property (nonatomic, retain) NSArray* sprites;
-(void) removeThisWall;
-(void) setBody : (b2Body*) body;
@end

@interface BallUserData : HBUserData {} @end
@interface StarUserData : HBUserData {} @end
@interface EnemyUserData : HBUserData {} @end
@interface CoinUserData : HBUserData {}
    -(void) setSprite:(CCSprite*)sprite;
@end

