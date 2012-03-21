//
//  GameManager.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameManager.h"
#import "StartScene.h"
#import "ControlLayer.h"
#import "Constants.h"
#import "GameLayer.h"
#import "GamePlayRootNode.h"
#import "PauseLayer.h"
#import "HBLevel.h"
#import "WinLevelLayer.h"

@implementation GameManager {
    
    @private
    CCScene * rootNode;
    HBLevel * levelScene;
    GameLayer * gameLayer;
    ControlLayer * controlLayer;
    
}

enum {
    GameLayerTag,
    LevelSceneTag,
    PauseLayerTag,
    ControlLayerTag,
    WinLevelLayerTag
};

GameManager * sharedInstance;

-(id) init {
    if(self = [super init]) {
        sharedInstance = self;
    }
    return self;
}

+(GameManager*) sharedInstance {
    return sharedInstance;
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
            levelScene = [Level1Scene node];
            break;
            
        case 2:
            levelScene = [Level2Scene node];
            break;
            
        default:
            break;
    }

    gameLayer = [GameLayer node];
    [gameLayer addChild:[CCTMXTiledMap tiledMapWithTMXFile:[levelScene getBackgroundTMX]] z:-1];
    
    controlLayer = [ControlLayer node];
    
    [rootNode addChild:levelScene z:0];
    [rootNode addChild:gameLayer z:0];
    [rootNode addChild:controlLayer z:0];
    
    [[CCDirector sharedDirector] replaceScene:rootNode];
    
}

-(void) handleWinLevel {
    [gameLayer setIsTouchEnabled: false];
    [gameLayer pauseSchedulerAndActions];
    [rootNode addChild:[WinLevelLayer layer] z:0 tag:WinLevelLayerTag];
}

-(CGSize) getCurrentLevelSize {
    return [levelScene getLevelSize];
}

-(void)markBodyForDeletion : (b2Body*)body {
    [gameLayer markBodyForDeletion :body];
}

-(CGPoint) getCurrentLevelStartPoint {
    return [levelScene getStartPoint];
}

-(CGPoint) getCurrentLevelEndPoint {
    return [levelScene getEndPoint];
}
                    
- (void)dealloc
{
    sharedInstance = nil;
    rootNode = nil;
    gameLayer = nil;
    controlLayer = nil;
    levelScene = nil;
    [super dealloc];
}

@end
