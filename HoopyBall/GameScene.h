//
//  GameScene.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface GameScene : CCScene {
    
}

+(GameScene*) sharedInstance;

-(void) handlePause;
-(void) handleUnpause;
-(void) handleEndGame;

-(void) markBodyForDeletion: (b2Body*)body andSprite: (CCSprite*)sprite inWorld: (b2World*) world;
-(void) cleanupDeletableItems;

@end
