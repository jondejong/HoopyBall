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
#import "Level1Scene.h"
#import "GameLayer.h"
#import "GamePlayRootNode.h"
#import "PauseLayer.h"
#import "HBLevel.h"

@implementation GameManager {
    
    @private
    
    CCScene * rootNode;
    Level1Scene * levelScene;
    GameLayer * gameLayer;
    ControlLayer * controlLayer;
    
}

enum {
    GameLayerTag,
    LevelSceneTag,
    PauseLayerTag,
    ControlLayerTag
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
    [rootNode addChild:[PauseLayer layer] z:0 tag:PauseLayerTag];
    }

-(void) handleUnpause {
    [rootNode removeChildByTag:PauseLayerTag cleanup:true]; 
    [controlLayer handleUnpause];
    [gameLayer resumeSchedulerAndActions];
}

-(void) handleEndLevel {
    [[CCDirector sharedDirector] replaceScene: [StartScene scene]];
}

-(void) handleStartLevel: (int) level {
   
    rootNode = [GamePlayRootNode scene];
    
    //The Level must be defined before the game layer, the game layer
    //is dependent upon values from the level
    levelScene = [Level1Scene node];
    gameLayer = [GameLayer node];

    [gameLayer addChild:[CCTMXTiledMap tiledMapWithTMXFile:[levelScene getCurrentBackgroundTMX]] z:-1];
    
    controlLayer = [ControlLayer node];
    
    [rootNode addChild:levelScene z:0];
    [rootNode addChild: gameLayer z:0];
    [rootNode addChild:controlLayer z:0];
    
    
        [[CCDirector sharedDirector] replaceScene:rootNode];
        
}

-(CGSize) getCurrentLevelSize {
    return [levelScene getCurrentLevelSize];
}

-(void)markBodyForDeletion: (b2Body*) body {
    [gameLayer markBodyForDeletion:body];
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
