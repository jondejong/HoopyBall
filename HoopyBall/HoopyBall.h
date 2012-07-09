//
//  HoopyBall.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "Box2D.h"
#import "cocos2d.h"
#import "HBLevel.h"
#import "ScoreLayer.h"
#import "ScreenSize.h"

#ifndef HoopyBall_HoopyBall_h
#define HoopyBall_HoopyBall_h

#define DEBUG_DRAW_OUTLINE 0

#define PTM_RATIO [ScreenSize ptmRatio]

#define START_VELOCITY_X 4.0f
//#define START_VELOCITY_X 7.0f
#define START_VELOCITY_Y 0.0f

#define WALL_RESTITUTION 1.07f
//#define WALL_RESTITUTION 1.00f

#define SHOW_FRAMERATE 0

// Usefull to see outside the ground box when debugging levels
#define CAMERA_FOLLOW_BALL 0

#define CAMERA_SCROLL_SCREEN_OFFSET .25f
#define OBJECT_FRICTION 0.5f

// Usefull to turn this off when working out issues
#define DRAW_ENEMIES 1

// Usefull to turn this on when trying to place the bad guy in a new level
#define START_WITH_BAD_GUY 0

//Usefull to turn this off when designing a new level
#define ALLOW_PLAYER_TO_WIN 1

// Layering
#define WALL_Z -4
#define OBSTACLE_Z -2
#define BALL_Z -2
#define BACKGROUNG_Z -10

@interface DeletableBody : NSObject
@property (nonatomic) b2Body *body;
-(id) initWithBody: (b2Body*)_body;
-(b2Body*) body;
-(bool) isAlreadyDeleted;
-(void) deleted;
@end // DeletableBody

@interface StartScene : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
}

+(CCScene *) scene;

@end //StartScene

@interface ControlLayer : CCLayer {
    
}

-(void) handlePause;
-(void) handleUnpause;
-(void) deactivate;

@end //ControlLayer

@interface GameLayer : CCLayer

@property(nonatomic, retain) NSMutableArray* bodiesToDelete;
@property(nonatomic, retain) CCTexture2D *blockTexture;
@property(nonatomic, retain) CCTexture2D *spriteTexture;
@property(nonatomic, retain) CCTexture2D *starTexture;
@property(nonatomic, retain) CCTexture2D *badGuyTexture;
@property(nonatomic, retain) CCTexture2D *wallTexture;
@property(nonatomic, retain) CCTexture2D *coinTexture;

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

@end // GameLayer

@interface GamePlayRootNode : CCScene {
    
}

+(CCScene*) scene;

@end //GamePlayRootNode

@interface GameManager : NSObject{
    
}

@property (nonatomic, retain) CCScene * rootNode;
@property (nonatomic, retain) HBLevel * levelScene;
@property (nonatomic, retain) GameLayer * gameLayer;
@property (nonatomic, retain) ControlLayer * controlLayer;
@property (nonatomic, retain) ScoreLayer * scoreLayer;

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
-(bool) addBadGuy;

-(void) markBodyForDeletion : (b2Body*)body;

-(void) addObstacle: (b2FixtureDef*)fixture with: (b2BodyDef*)body andWith: (CCSprite*) sprite;
-(void) addCachedObstacle: (NSString*)fixtureShapeName with: (b2BodyDef*)body andWith: (CCSprite*) sprite;

-(void) addCachedObstacle: (NSString*)fixtureShapeName with: (b2BodyDef*)body;

-(void) addTarget: (b2FixtureDef*)fixture with: (b2BodyDef*)body andWith: (CCSprite*) sprite;

-(void) removeSpriteFromGame: (CCSprite*) sprite;
-(void) addToScore: (int) scoreAddition;

@end //GameManager

#endif
