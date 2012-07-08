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

@implementation Level06Scene {
    
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
        size.width = 1280;
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
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level6_bg-hd.tmx" : @"level6_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 3); }

-(CGPoint) getEndPoint {
    return ccp(5, 10);
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
    for(int i = 2; i < 11;  i++){
        [self addBrickAt: ccp(0.0f, i*brickSideLen)];
    }
    
    //bottom
    [self addBrickAt:ccp(brickSideLen, 0.0f)];
    [self addBrickAt:ccp(2 * brickSideLen, 0.0f)];
    
    for(int i=4; i<10; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 0.0f)];
    }
    
    //top
    for(int i=1; i<10; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 9*brickSideLen)];
    }
    
    //right
    for(int i=1; i<9; i++) {
        [self addBrickAt:ccp(9 * brickSideLen, i*brickSideLen)];
    }
    
    [self addObs1At: ccp(5,5)];
    [self addObs1At: ccp(5, 14.75)];
    [self addObs1At: ccp(9, 11.5)];
    [self addObs1At: ccp(9, 7)];;
    
}

-(void) createTargets {
    
    for(int i=8; i<18; i+=2) {
        [self addCoinAt:ccp(4, i)];
    }
    
    for(float i=10; i<17; i+=1.5) {
        [self addCoinAt:ccp(14, i)];
        [self addCoinAt:ccp(16, i)];
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