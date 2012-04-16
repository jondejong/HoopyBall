//
//  CoinUserData.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "HBUserData.h"
#import "GameManager.h"

@implementation CoinUserData {
@private CCSprite* _sprite;
}



-(void) handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody {
    if(BALL_NODE_TYPE == [otherBody nodeType]) {
        [[GameManager sharedInstance] markBodyForDeletion: thisBody];
        [[GameManager sharedInstance] removeSpriteFromGame: _sprite];
    }
}

-(int) nodeType {return COIN_NODE_TYPE;}

-(void) setSprite:(CCSprite*)sprite {
    _sprite = sprite;
    [_sprite retain];
}

- (void)dealloc
{
    [_sprite release];
    [super dealloc];
}

@end