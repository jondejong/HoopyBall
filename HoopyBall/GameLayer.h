//
//  GameLayer.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "WallContactListener.h"

@interface GameLayer : CCLayer
{
    
}

-(void)handleEndGame;

-(void) initPhysics;
-(void) addNewSpriteAtPosition:(CGPoint)p;
-(void) addNewWall:(CGPoint)p withLength: (float) l andAndle: (float) a;
-(void) initStartLocation;
-(float) vec2rad : (b2Vec2) v;

@end
