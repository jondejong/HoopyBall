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
#import "Constants.h"
#import "GB2ShapeCache.h"

@implementation GameScene {
    
    @private
    CCArray* bodiesToDelete;
    float xOffset;
    float yOffset;
}

static GameScene* instance;

float height = 0.0;
float width = 0.0;



enum {
    BackgroundLayerTag = 1,
    PauseLayerTag = 2,
    ControlLayerTag = 3,
    GameLayerTag = 4
};
 
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        instance = self;
        xOffset = 0.0f;
        yOffset = 0.0f;
        
#if USE_LARGE_WORLD
        height = 2048;
        width = 4096;
//        height = 1000;
//        width = 1400;
#else
        height = [[CCDirector sharedDirector] winSize].height;
        width = [[CCDirector sharedDirector] winSize].width;
#endif
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"hoopy-ball-shapes.plist"];
        [self addChild: [BackgroundLayer node] z:0 tag: BackgroundLayerTag];
        [self addChild:[GameLayer node] z:0 tag:GameLayerTag];
        bodiesToDelete = [[CCArray alloc] initWithCapacity:50];
        
    }
    return self;
}  

+(GameScene*) sharedInstance {
    return instance;
}

-(CGSize) getCurrentLevelSize {
    CGSize s;
    s.height = height;
    s.width = width;
    return s;
}

-(void)updateBGPosition: (CGPoint)position {
#if USE_LARGE_WORLD
    [self doUpdateBGPosition:position];
#endif
}

-(void) doUpdateBGPosition: (CGPoint) position{
#if CAMERA_FOLLOW_BALL
    CCLOG(@"Following ball at %f, %f", position.x, position.y);
    xOffset = position.x - [[CCDirector sharedDirector] winSize].width / 2.0f;
    yOffset = position.y - [[CCDirector sharedDirector] winSize].height / 2.0f;
            
    [self.camera setCenterX:xOffset centerY:yOffset centerZ:0];
    [self.camera setEyeX:xOffset eyeY:yOffset eyeZ:[CCCamera getZEye]]; 
#else
    // Grab some values to work wtih
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    CGSize levelSize = [[GameScene sharedInstance] getCurrentLevelSize]; 
    
    float xThresholdOffset = windowSize.width/4.0f;
    float yThresholdOffset = windowSize.height/4.0f;
    
    // Find out the current edge of the viewport
    float cameraX, cameraY, cameraZ;
    
    [self.camera centerX:&cameraX centerY:&cameraY centerZ:&cameraZ];
    
    // see if we need to move the X
    if( (position.x < (cameraX + xThresholdOffset)) && cameraX > 0) {
        float xMove = cameraX + xThresholdOffset - position.x;
        xOffset -= xMove;
        
    } else if( (position.x > ((cameraX + windowSize.width) - xThresholdOffset)) && (cameraX + windowSize.width) < levelSize.width){
        float xMove = xThresholdOffset - (cameraX + windowSize.width - position.x);
        xOffset += xMove;
    }
    
    // see if we need to move the Y
    if( (position.y < (cameraY + yThresholdOffset)) && cameraY > 0) {
        float yMove = cameraY + yThresholdOffset - position.y;
        yOffset -= yMove;
    } else if( (position.y > ((cameraY + windowSize.height) - yThresholdOffset)) && (cameraY + windowSize.height) <= levelSize.height){
        float yMove = yThresholdOffset - (cameraY + windowSize.height - position.y);
        yOffset += yMove;
    }
    
    [self.camera setCenterX:xOffset centerY:yOffset centerZ:0];
    [self.camera setEyeX:xOffset eyeY:yOffset eyeZ:[CCCamera getZEye]];
    
#endif
}

-(void) handlePause {
    CCLayer* gameLayer = (CCLayer *)[self getChildByTag:GameLayerTag];
    gameLayer.isTouchEnabled = false;
    [gameLayer pauseSchedulerAndActions];    
}

-(void) handleUnPause {
    CCLayer* gameLayer = (CCLayer *)[self getChildByTag:GameLayerTag];
    gameLayer.isTouchEnabled = true;
    [gameLayer resumeSchedulerAndActions];
}

-(void) handleEndGame {
    [(GameLayer*)[self getChildByTag:GameLayerTag] handleEndGame];
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

-(float) getXOffset {return xOffset;}
-(float) getYOffset {return yOffset;}

-(void) dealloc 
{
    bodiesToDelete = nil;
    [super dealloc];    
}

@end
