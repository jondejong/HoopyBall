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

@implementation Level08Scene {
    
@private
    CGSize size;
    CCTexture2D* brickTexture_;
    CCTexture2D* obs1Texture_;
    CCTexture2D* coinTexture_;
    
    float brickSideLen;
    
    enum {
        kBrickParentTag = 1,
        kObs1ParentTag = 2
    };
}

-(id) init {
    if(self = [super init]) {
        brickSideLen = 2;
        size.width = 3840;
        size.height = 3200;
        
        
        //Cache obstacle textures
        
        CCSpriteBatchNode *brick = [CCSpriteBatchNode batchNodeWithFile:@"l2_base_brick.png" capacity:100];
        brickTexture_ = [brick texture];
        [self addChild:brick z:0 tag: kBrickParentTag];
        
        CCSpriteBatchNode *obs1 = [CCSpriteBatchNode batchNodeWithFile:@"l2_obs_1_base.png" capacity:100];
        obs1Texture_ = [obs1 texture];
        [self addChild:obs1 z:0 tag: kObs1ParentTag];
        
        // Add Obstacle Shapes to cache
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"l2_obs_shapes.plist"];
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level2_bg-hd.tmx" : @"level2_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 3); }

-(CGPoint) getEndPoint {
    return ccp(20, 20);
}

-(CGPoint) getBadGuyStartPoint {
    return ccp(7, .5);
}

-(int) getBadGuyFrequency {return 300;}

-(float) getBadGuyXSpeed {
    return  0;
}
-(float) getBadGuyYSpeed {return 4;}

-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    
    //left wall
    for(int i = 2; i < 25;  i++){
        [self addBrickAt: ccp(0.0f, i*brickSideLen)];
    }
    
    //bottom
    [self addBrickAt:ccp(brickSideLen, 0.0f)];
    [self addBrickAt:ccp(2 * brickSideLen, 0.0f)];
    
    for(int i=4; i<30; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 0.0f)];
    }
    
    //top
    for(int i=1; i<30; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 24*brickSideLen)];
    }
    
    //right
    for(int i=1; i<29; i++) {
        [self addBrickAt:ccp(29 * brickSideLen, i*brickSideLen)];
    }
    
    [self addObs1At: ccp(5,5)];
    [self addObs1At: ccp(5, 15)];
    [self addObs1At: ccp(5, 25)];
    [self addObs1At: ccp(5, 35)];
    
    [self addObs1At: ccp(15, 5)];
    [self addObs1At: ccp(15, 15)];
    [self addObs1At: ccp(15, 25)];
    [self addObs1At: ccp(15, 35)];
    
    [self addObs1At: ccp(25, 5)];
    [self addObs1At: ccp(25, 15)];
    [self addObs1At: ccp(25, 25)];
    [self addObs1At: ccp(25, 35)];
    
    [self addObs1At: ccp(35, 5)];
    [self addObs1At: ccp(35, 15)];
    [self addObs1At: ccp(35, 25)];
    [self addObs1At: ccp(35, 35)];
    
}

-(void) createTargets {
    
    for(int i=9; i<46; i+=2) {
        [self addCoinAt:ccp(4, i)];
    }
    
    for(int i=9; i<46; i+=2) {
        [self addCoinAt:ccp(50, i)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 45)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 43)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 41)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 39)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 37)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 35)];
    }
    
}

-(void) addObs1At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture:obs1Texture_ ];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l2_obs_1_base"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l2_obs_1_base" with:&bodyDef andWith:sprite];
    
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
    coinTexture_ = nil;
    brickTexture_ = nil;
    obs1Texture_ = nil;
    [super dealloc];
}
@end
