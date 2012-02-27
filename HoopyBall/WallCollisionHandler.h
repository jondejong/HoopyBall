//
//  WallCollisionHandler.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface WallCollisionHandler :CCNode {
    
}

-(id) initWithWorld:(b2World*) _world andBody:(b2Body*)_body andSprite: (CCSprite*)_sprite;

-(void) handleCollision;

@end
