//
//  GameManager.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface GameManager : NSObject{
    
}

+(GameManager*) sharedInstance;

-(void) startGame;
-(void) handlePause;
-(void) handleUnpause;
-(void) handleEndLevel;
-(void) handleStartLevel: (int) level;

-(void) handleWinLevel;
-(void) handleLoseLevel;

-(void) handleLevelPlayStarted;

-(CGPoint) getCurrentLevelEndPoint;
-(CGSize) getCurrentLevelSize;
-(CGPoint) getCurrentLevelStartPoint;

-(CGPoint) getCurrentLevelBadGuyPoint;
-(float) getCurrentLevelBadGuyXSpeed;
-(float) getCurrentLevelBadGuyYSpeed;
-(int) getCurrentLevelBadGuyFrequency;

-(void) markBodyForDeletion : (b2Body*)body;

-(void) addObstacle: (b2FixtureDef*)fixture with: (b2BodyDef*)body andWith: (CCSprite*) sprite;
-(void) addCachedObstacle: (NSString*)fixtureShapeName with: (b2BodyDef*)body andWith: (CCSprite*) sprite;

-(void) addCachedObstacle: (NSString*)fixtureShapeName with: (b2BodyDef*)body;

-(void) addTarget: (b2FixtureDef*)fixture with: (b2BodyDef*)body andWith: (CCSprite*) sprite;

-(void) removeSpriteFromGame: (CCSprite*) sprite;
-(void) addToScore: (int) scoreAddition;

@end
