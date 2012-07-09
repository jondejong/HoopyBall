//
//  GameManager.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"
#import "PauseLayer.h"
#import "HBLevel.h"
#import "WinLevelLayer.h"
#import "LoseLevelLayer.h"
#import "ScoreLayer.h"
#import "StartLevelLayer.h"

@implementation GameManager {
    
}


@synthesize rootNode;
@synthesize levelScene;
@synthesize gameLayer;
@synthesize controlLayer;
@synthesize scoreLayer;

enum {
    GameLayerTag,
    LevelSceneTag,
    PauseLayerTag,
    ControlLayerTag,
    WinLevelLayerTag,
    LoseLevelLayerTag,
    ScoreLayerTag,
    StartLevelTag
};

GameManager * _sharedInstance;

-(id) init {
    if(self = [super init]) {
        _sharedInstance = self;
    }
    return self;
}

+(GameManager*) sharedInstance {
    return _sharedInstance;
}

-(void) startGame {
    [[CCDirector sharedDirector] pushScene: [StartScene scene]];
}

-(void) handlePause {
    [gameLayer pauseSchedulerAndActions];
    [gameLayer setIsTouchEnabled:false];
    [rootNode addChild:[PauseLayer layer] z:0 tag:PauseLayerTag];
}

-(void) handleUnpause {
    [rootNode removeChildByTag:PauseLayerTag cleanup:true]; 
    [controlLayer handleUnpause];
    [gameLayer setIsTouchEnabled: true];
    [gameLayer resumeSchedulerAndActions];
}

-(void) handleEndLevel {
    [[CCDirector sharedDirector] replaceScene: [StartScene scene]];
}

-(void) handleStartLevel: (int) level {
    
    rootNode = [GamePlayRootNode scene];
    
    //The Level must be defined before the game layer, the game layer
    //is dependent upon values from the level
    switch (level) {
        case 1:
            self.levelScene = [Level01Scene node];
            break;
            
        case 2:
            self.levelScene = [Level02Scene node];
            break;
            
        case 3:
            self.levelScene = [Level03Scene node];
            break;
        
        case 4:
            self.levelScene = [Level04Scene node];
            break;
            
        case 5:
            self.levelScene = [Level05Scene node];
            break;
            
        case 6:
            self.levelScene = [Level06Scene node];
            break;
            
        case 7:
            self.levelScene = [Level07Scene node];
            break;
            
        case 8:
            self.levelScene = [Level08Scene node];
            break;
            
        case 9:
            self.levelScene = [Level09Scene node];
            break;
            
        case 10:
            self.levelScene = [Level10Scene node];
            break;
         
        case 11:
            self.levelScene = [Level11Scene node];
            break;
            
        case 12:
            self.levelScene = [Level12Scene node];
            break;
            
        case 13:
            self.levelScene = [Level13Scene node];
            break;
            
        case 14:
            self.levelScene = [Level14Scene node];
            break;
            
        case 15:
            self.levelScene = [Level15Scene node];
            break;
        default:
            break;
    }
    
    self.gameLayer = [GameLayer node];
    [gameLayer addChild:[CCTMXTiledMap tiledMapWithTMXFile:[levelScene getBackgroundTMX]] z:BACKGROUNG_Z];
    
    NSString * obsTmx = [levelScene getObsTMX];
    if(obsTmx){
        [gameLayer addChild:[CCTMXTiledMap tiledMapWithTMXFile:obsTmx] z:OBSTACLE_Z];
    }
    
    controlLayer = [ControlLayer node];
    
    scoreLayer = [ScoreLayer node];
    
    [rootNode addChild:gameLayer z:0];
    [rootNode addChild:levelScene z:0];
    [rootNode addChild:controlLayer z:0];
    [rootNode addChild:scoreLayer z:0];
    
    [rootNode addChild: [StartLevelLayer layer] z:0 tag:StartLevelTag];
    
    [levelScene createObstacles];
    [levelScene createTargets];
    
    [controlLayer deactivate];
    
    [[CCDirector sharedDirector] replaceScene:rootNode];
    
}

-(void) handleWinLevel {
    [gameLayer setIsTouchEnabled: false];
    [gameLayer pauseSchedulerAndActions];
    [controlLayer deactivate];
    WinLevelLayer* winLayer = [WinLevelLayer layer];
    [rootNode addChild:winLayer z:0 tag:WinLevelLayerTag];
    [winLayer displayScore: [scoreLayer getScore]];
}

-(void) handleLoseLevel {
    [gameLayer setIsTouchEnabled: false];
    [gameLayer pauseSchedulerAndActions];
    [controlLayer deactivate];
    [rootNode addChild:[LoseLevelLayer layer] z:0 tag:LoseLevelLayerTag];
}

-(void) handleLevelPlayStarted {
    [rootNode removeChildByTag:StartLevelTag cleanup:true];
    [levelScene start];
    [controlLayer handleUnpause];
}

-(CGPoint) getCurrentLevelEndPoint {
    return [levelScene getEndPoint];
}

-(CGSize) getCurrentLevelSize {
    return [levelScene getLevelSize];
}

-(CGPoint) getCurrentLevelStartPoint {
    return [levelScene getStartPoint];
}

-(CGPoint) getCurrentLevelEnemyPoint{
    return [levelScene getEnemyStartPoint];
}

-(float) getCurrentLevelEnemyXSpeed {
    return [levelScene getEnemyXSpeed];
}

-(float) getCurrentLevelEnemyYSpeed {
    return [levelScene getEnemyYSpeed];
}

-(bool) addEnemy {
    return [levelScene addEnemy];
}

-(void)markBodyForDeletion : (b2Body*)body {
    [gameLayer markBodyForDeletion :body];
}


-(void) addObstacle: (b2FixtureDef*)fixture with: (b2BodyDef*)body andWith: (CCSprite*) sprite {
    [gameLayer addStaticBody: fixture with: body andWith: sprite];
}

-(void) addCachedObstacle: (NSString*)fixtureShapeName with: (b2BodyDef*)body andWith: (CCSprite*) sprite {
    [gameLayer addCachedStaticBody: fixtureShapeName with: body andWith: sprite];
}

-(void) addCachedObstacle: (NSString*)fixtureShapeName with: (b2BodyDef*)body {
    [gameLayer addCachedStaticBody: fixtureShapeName with: body];   
}

-(void) addTarget: (b2FixtureDef*)fixture with: (b2BodyDef*)body andWith: (CCSprite*) sprite {
    [gameLayer addStaticBody:fixture with:body andWith:sprite];
}

-(void) removeSpriteFromGame: (CCSprite*) sprite {
    [gameLayer removeChild:sprite cleanup:true];
}

-(void) addToScore: (int) scoreAddition {
    [scoreLayer addToScore:scoreAddition];
}

- (void)dealloc
{
    [rootNode release];
    [levelScene release];
    [gameLayer release];
    [controlLayer release];
    [scoreLayer release];
    
    _sharedInstance = nil;
    rootNode = nil;
    gameLayer = nil;
    controlLayer = nil;
    levelScene = nil;
    scoreLayer = nil;
    [super dealloc];
}

@end
