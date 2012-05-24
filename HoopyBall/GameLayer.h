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

-(void) markBodyForDeletion:(b2Body*)body;
-(void) cleanupDeletableItems;

-(void) initPhysics;
-(void) addBall;
-(void) addNewWall:(CGPoint)p withLength: (float) l andAndle: (float) a;
-(void) initStartLocation;
-(float) vec2rad : (b2Vec2) v;

-(void) updateBGPosition: (CGPoint)position;

-(void) addBadGuy;

-(void) addStaticBody: (b2FixtureDef*)fixture with: (b2BodyDef*)bodyDef andWith: (CCSprite*) sprite;
-(void) addCachedStaticBody: (NSString*)fixtureShapeName with: (b2BodyDef*)bodyDef andWith: (CCSprite*) sprite;

-(void) addCachedStaticBody: (NSString*)fixtureShapeName with: (b2BodyDef*)bodyDef;

@end
