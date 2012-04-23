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

@interface GameLayer : CCLayer{
    
}

#ifndef GAME_LAYER_H
#define GAME_LAYER_H

#define WALL_Z 10
#define OBSTACLE_Z 20
#define BALL_Z 20

#endif


//-(float) getXOffset;
//-(float) getYOffset;

-(void) markBodyForDeletion:(b2Body*)body;
-(void) cleanupDeletableItems;

-(void) initPhysics;
-(void) addBall;
-(void) addNewWall:(CGPoint)p withLength: (float) l andAndle: (float) a;
-(void) initStartLocation;
-(float) vec2rad : (b2Vec2) v;

-(void) updateBGPosition: (CGPoint)position;
-(void) doUpdateBGPosition: (CGPoint) postition;

-(void) addBadGuy;

-(void) addStaticBody: (b2FixtureDef*)fixture with: (b2BodyDef*)bodyDef andWith: (CCSprite*) sprite;

@end
