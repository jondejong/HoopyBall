//
//  CoinUserData.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "HoopyBall.h"

#import "cocos2d.h"
#import "HBUserData.h"

@implementation CoinUserData {
@private CCSprite* _sprite;
}

-(void) handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody {
    if(BALL_NODE_TYPE == [otherBody nodeType]) {
        [[GameManager sharedInstance] addToScore: 1];
        [[GameManager sharedInstance] markBodyForDeletion: thisBody];
        [[GameManager sharedInstance] removeSpriteFromGame: _sprite];
    }
}

-(int) nodeType {return COIN_NODE_TYPE;}

-(void) setSprite:(CCSprite*)sprite {
    _sprite = sprite;
}

@end