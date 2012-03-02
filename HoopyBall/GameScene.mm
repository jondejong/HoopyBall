//
//  GameScene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "BackgroundLayer.h"
#import "PauseLayer.h"
#import "ControlLayer.h"
#import "GameLayer.h"
#import "BoxLayer.h"
#import "HelloWorldLayer.h"
#import "Support/ccCArray.h"
#import "DeletableBody.h"

@implementation GameScene {

    @private
    ControlLayer* controlLayer;
    CCArray* bodiesToDelete;
}

static GameScene* instance;

enum {
    BackgroundLayerTag,
    PauseLayerTag,
    ControlLayerTag,
    GameLayerTag
};

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        instance = self;

        [self addChild: [BackgroundLayer node] z:0 tag: BackgroundLayerTag];
        
        controlLayer = [ControlLayer node];
        [self addChild:[GameLayer node] z:0 tag:GameLayerTag];
        [self addChild:controlLayer z:0 tag:ControlLayerTag];
        
        bodiesToDelete = [[CCArray alloc] initWithCapacity:50];

    }
    return self;
}   

+(GameScene *) sharedInstance {
    return instance;
}

-(void) handlePause 
{
    CCLayer* boxLayer = (CCLayer *)[self getChildByTag:GameLayerTag];
    boxLayer.isTouchEnabled = false;
    [boxLayer pauseSchedulerAndActions];
    [self addChild: [PauseLayer layer] z:0 tag:PauseLayerTag];
}

-(void) handleUnpause
{
    [self removeChildByTag:PauseLayerTag cleanup:true];
    CCLayer* boxLayer = (CCLayer *)[self getChildByTag:GameLayerTag];
    boxLayer.isTouchEnabled = true;
    [boxLayer resumeSchedulerAndActions];
    [controlLayer unpause];
    
}

-(void) handleEndGame {
    [(GameLayer*)[self getChildByTag:GameLayerTag] handleEndGame];
    [[CCDirector sharedDirector] replaceScene: [HelloWorldLayer scene]];
}

//-(void) markBodyForDeletion: (b2Body*)body andSprite: (CCSprite*)sprite inWorld: (b2World*) world {
-(void) markBodyForDeletion: (b2Body*)body inWorld: (b2World*) world {
    [bodiesToDelete addObject:[[DeletableBody alloc] initWithBody:body inWorld:world]];
}

-(void) cleanupDeletableItems {

    for(int i=0; i < [bodiesToDelete count]; i++) {
        DeletableBody* db = [bodiesToDelete objectAtIndex:i];
        b2World* world = [db world]; 
        b2Body* body = [db body];
        world->DestroyBody(body);
//        CCSprite* sprite = [db sprite];
//        [sprite removeFromParentAndCleanup:true];
    }
    [bodiesToDelete dealloc];
     bodiesToDelete = [[CCArray alloc] initWithCapacity:50];
}

-(void) dealloc 
{
    bodiesToDelete = nil;
    controlLayer = nil;
    instance = nil;
    [super dealloc];    
}

@end
