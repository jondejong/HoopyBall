//
//  RootNode.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePlayRootNode.h"
#import "GameScene.h"
#import "ControlLayer.h"
#import "GameLayer.h"
#import "PauseLayer.h"
#import "HelloWorldLayer.h"

@implementation GamePlayRootNode {
@private

}

static GamePlayRootNode* instance;

enum {
    BackgroundLayerTag,
    GameSceneTag,
    PauseLayerTag,
    ControlLayerTag
};

- (id)init
{
    self = [super init];
    if (self) {
        [self addChild: [GameScene node] z:0 tag:GameSceneTag];
        
        [self addChild:[ControlLayer node] z:0 tag:ControlLayerTag];
        instance = self;
    }
    return self;
}

+(GamePlayRootNode *) sharedInstance {
    return instance;
}

-(void) handlePause 
{
    [[GameScene sharedInstance] handlePause];
    [self addChild: [PauseLayer layer] z:0 tag:PauseLayerTag];
}

-(void) handleUnpause
{
    [[GameScene sharedInstance] handleUnPause];
    [(ControlLayer*)[self getChildByTag:ControlLayerTag] handleUnpause];
    [self removeChildByTag:PauseLayerTag cleanup:true];
}

-(void) handleEndGame {
    [[GameScene sharedInstance] handleEndGame];
    [[CCDirector sharedDirector] replaceScene: [HelloWorldLayer scene]];
}

-(void) dealloc 
{
    instance = nil;
    [super dealloc];    
}


@end
