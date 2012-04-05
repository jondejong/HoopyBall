//
//  WallCollisionHandler.m
//  ;
//
//  Created by Jonathan DeJong on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "GamePlayRootNode.h"
#import "GameManager.h"
#import "HBUserData.h"
#import "cocos2d.h"

@implementation WallUserData {

    @private
    NSArray* _sprites;
}
    


-(void)handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody {
    
    if(otherBody.nodeType == BALL_NODE_TYPE) {
        [[GameManager sharedInstance] markBodyForDeletion: thisBody];
        for(CCSprite * sprite in _sprites) {
            [[GameManager sharedInstance] removeSpriteFromGame:sprite];
        }
    }
}

-(int) nodeType {
    return WALL_NODE_TYPE;
}

-(NSArray *) sprites {
    return _sprites;
}

-(void) setSprites: (NSArray *) sprites {
    _sprites = sprites;
    [_sprites retain];
}

- (void)dealloc{
    
    for(int i = 0; i<[_sprites count]; i++) {
        [[_sprites objectAtIndex:i] release];
    }
    
    [_sprites release];
    [super dealloc];
}



@end
