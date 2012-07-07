//
//  Level2Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level12Scene {
    
@private
    CGSize size;
    CCTexture2D* brickTexture_;
    CCTexture2D* obs1Texture_;
    CCTexture2D* obs2Texture_;
    
    float brickSideLen;
    
    enum {
        kBrickParentTag = 1,
        kObs1ParentTag = 2,
        kObs2ParentTag = 3
    };
}

-(id) init {
    if(self = [super init]) {
        brickSideLen = 2;
        size.width = 1024;
        size.height = 6400;
        
        //Cache obstacle textures
        
        CCSpriteBatchNode *brick = [CCSpriteBatchNode batchNodeWithFile:@"level3_base_brick.png" capacity:100];
        brickTexture_ = [brick texture];
        [self addChild:brick z:0 tag: kBrickParentTag];
        
        CCSpriteBatchNode *obs1 = [CCSpriteBatchNode batchNodeWithFile:@"l3_obs1.png" capacity:10];
        obs1Texture_ = [obs1 texture];
        [self addChild:obs1 z:0 tag: kObs1ParentTag];
        
        CCSpriteBatchNode *obs2 = [CCSpriteBatchNode batchNodeWithFile:@"l3_obs2.png" capacity:10];
        obs2Texture_ = [obs2 texture];
        [self addChild:obs2 z:0 tag: kObs2ParentTag];
        
        // Add Obstacle Shapes to cache
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"l3_obs_shapes.plist"];
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"l3_bg-hd.tmx" : @"l3_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 3); }

-(CGPoint) getEndPoint {
    return ccp(10, 45);
}

-(CGPoint) getBadGuyStartPoint {
    return ccp(13, .5);
}

-(int) getBadGuyFrequency {return 700;}

-(float) getBadGuyXSpeed {
    return  0;
}
-(float) getBadGuyYSpeed {return 4;}

-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    
    //left wall
    for(int i = 2; i < 50;  i++){
        [self addBrickAt: ccp(0.0f, i*brickSideLen)];
    }
    
    //bottom
    for(int i=0; i<6; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 0.0f)];
    }
    
    [self addBrickAt:ccp(7.0f * brickSideLen, 0.0f)];
    
    //top
    for(int i=1; i<8; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 49*brickSideLen)];
    }
    
    //right
    for(int i=1; i<50; i++) {
        [self addBrickAt:ccp(7 * brickSideLen, i*brickSideLen)];
    }
    
    [self addObs1At: ccp(3,2)];
    [self addObs1At: ccp(2,10)];
    [self addObs2At: ccp(4,20)];
    
    [self addObs1At: ccp(2,30)];
    [self addObs2At: ccp(4,40)];
    
    [self addObs1At: ccp(2,50)];
    [self addObs2At: ccp(4,60)];
    
}

-(void) createTargets {
    
    [self addCoinAt:ccp(2.5f, 12.0f)];
    [self addCoinAt:ccp(3.0f, 13.0f)];
    [self addCoinAt:ccp(3.5f, 14.0f)];
    
    [self addCoinAt:ccp(2.5f, 32.0f)];
    [self addCoinAt:ccp(3.0f, 33.0f)];
    [self addCoinAt:ccp(3.5f, 34.0f)];
    
    [self addCoinAt:ccp(12.5f, 22.0f)];
    [self addCoinAt:ccp(12.0f, 23.0f)];
    [self addCoinAt:ccp(11.5f, 24.0f)];
    
    [self addCoinAt:ccp(12.5f, 42.0f)];
    [self addCoinAt:ccp(12.0f, 43.0f)];
    [self addCoinAt:ccp(11.5f, 44.0f)];
    
    [self addCoinAt:ccp(2.5f, 52.0f)];
    [self addCoinAt:ccp(3.0f, 53.0f)];
    [self addCoinAt:ccp(3.5f, 54.0f)];
    
    [self addCoinAt:ccp(12.5f, 62.0f)];
    [self addCoinAt:ccp(12.0f, 63.0f)];
    [self addCoinAt:ccp(11.5f, 64.0f)];
    
    // Top blob
    for(int i=3; i<15; i+=2) {
        for(int j=70; j<97; j+=2){
            [self addCoinAt:ccp(i, j)];
        }
    }
    
    
}


-(void) addObs1At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture:obs1Texture_ ];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l3_obs1"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l3_obs1" with:&bodyDef andWith:sprite];
    
}

-(void) addObs2At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture:obs2Texture_ ];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l3_obs2"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l3_obs2" with:&bodyDef andWith:sprite];
    
}

-(void) addBrickAt: (CGPoint) p {
    p = ccp(p.x + 1, p.y + 1);
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(p.x, p.y);
    
    HBUserData* data = [HBUserData node];
    [self addChild:data];
    bodyDef.userData = data;
    
    b2PolygonShape brickShape;
    brickShape.SetAsBox(1.0, 1.0);
    b2FixtureDef fixture;
    fixture.shape = &brickShape;
    fixture.friction = OBJECT_FRICTION;
    fixture.density = 1.0;
    fixture.restitution = 1.0;
    
    CCSprite *sprite = [CCSprite spriteWithTexture:brickTexture_ ];	
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    
    [[GameManager sharedInstance] addObstacle:&fixture with:&bodyDef andWith: sprite];
    
}

- (void)dealloc
{
    brickTexture_ = nil;
    obs1Texture_ = nil;
    obs2Texture_ = nil;
    [super dealloc];
}
@end
