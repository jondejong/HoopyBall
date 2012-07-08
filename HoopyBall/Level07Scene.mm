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

@implementation Level07Scene {
    
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
        size.width = 1792;
        size.height = 1280;
        
        //Cache obstacle textures
        
        CCSpriteBatchNode *brick = [CCSpriteBatchNode batchNodeWithFile:@"l2_base_brick.png" capacity:100];
        brickTexture_ = [brick texture];
        [self addChild:brick z:0 tag: kBrickParentTag];
        
        CCSpriteBatchNode *obs1 = [CCSpriteBatchNode batchNodeWithFile:@"l2_obs_1_base_small.png" capacity:100];
        obs1Texture_ = [obs1 texture];
        [self addChild:obs1 z:0 tag: kObs1ParentTag];
        
        // Add Obstacle Shapes to cache
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"l2_obs_shapes.plist"];
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level7_bg-hd.tmx" : @"level7_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 3); }

-(CGPoint) getEndPoint {
    return ccp(10, 10);
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
    for(int i = 2; i < 10;  i++){
        [self addBrickAt: ccp(0.0f, i*brickSideLen)];
    }
    
    //bottom
    [self addBrickAt:ccp(brickSideLen, 0.0f)];
    [self addBrickAt:ccp(2 * brickSideLen, 0.0f)];
    
    for(int i=4; i<14; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 0.0f)];
    }
    
    //top
    for(int i=1; i<14; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 9*brickSideLen)];
    }
    
    //right
    for(int i=1; i<9; i++) {
        [self addBrickAt:ccp(13 * brickSideLen, i*brickSideLen)];
    }
    
    [self addObs1At: ccp(5, 5)];
    [self addObs1At: ccp(5, 11.5)];
    [self addObs1At: ccp(9, 14.75)];
    [self addObs1At: ccp(9, 7)];
    
    [self addObs1At: ccp(13, 5)];
    [self addObs1At: ccp(13, 11.5)];
    [self addObs1At: ccp(17, 14.75)];
    [self addObs1At: ccp(17, 7)];
    
    [self addObs1At: ccp(20, 4)];
    [self addObs1At: ccp(20, 9)];
    [self addObs1At: ccp(20, 14)];

}

-(void) createTargets {
    
    for(int i=8; i<18; i+=2) {
        [self addCoinAt:ccp(4, i)];
    }

    [self addCoinAt:ccp(5.5, 16)];
    [self addCoinAt:ccp(7, 16)];
    [self addCoinAt:ccp(8.5, 16)];
    
    [self addCoinAt:ccp(24, 5)];
    [self addCoinAt:ccp(23.5, 8)];
    [self addCoinAt:ccp(24.5, 8)];
    
    for(float i=11; i<18; i+=1.2) {
        [self addCoinAt:ccp(22.8, i)];
        [self addCoinAt:ccp(24, i)];
        [self addCoinAt:ccp(25.2, i)];
    }
    
    for(int i=4; i<18; i+=2) {
        [self addCoinAt:ccp(15.5, i)];
    }
    
}


-(void) addObs1At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture:obs1Texture_ ];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l2_obs_1_base_small"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l2_obs_1_base_small" with:&bodyDef andWith:sprite];
    
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
