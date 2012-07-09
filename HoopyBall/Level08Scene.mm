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
    float brickSideLen;
    
    enum {
        kBrickParentTag = 1,
        kObs1ParentTag = 2,
        kObs2ParentTag = 3,
        kSmallObstacleType = 4,
        kBigObstacleType = 5
    };
}

@synthesize brickTexture;
@synthesize obs1Texture;
@synthesize obs2Texture;

-(id) init {
    if(self = [super init]) {
        brickSideLen = 2;
        size.width = 3200;
        size.height = 1792;
        
        //Cache obstacle textures
        
        CCSpriteBatchNode *brick = [CCSpriteBatchNode batchNodeWithFile:@"l2_base_brick.png" capacity:100];
        self.brickTexture = [brick texture];
        [self addChild:brick z:0 tag: kBrickParentTag];
        
        CCSpriteBatchNode *obs1 = [CCSpriteBatchNode batchNodeWithFile:@"l2_obs_1_base.png" capacity:100];
        self.obs1Texture = [obs1 texture];
        [self addChild:obs1 z:0 tag: kObs1ParentTag];
        
        CCSpriteBatchNode *obs2 = [CCSpriteBatchNode batchNodeWithFile:@"l2_obs_1_base_small.png" capacity:100];
        self.obs2Texture = [obs2 texture];
        [self addChild:obs2 z:0 tag: kObs2ParentTag];
        
        // Add Obstacle Shapes to cache
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"l2_obs_shapes.plist"];
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level8_bg-hd.tmx" : @"level8_bg.tmx";}

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
    for(int i = 2; i < 14;  i++){
        [self addBrickAt: ccp(0.0f, i*brickSideLen)];
    }
    
    //bottom
    [self addBrickAt:ccp(brickSideLen, 0.0f)];
    [self addBrickAt:ccp(2 * brickSideLen, 0.0f)];
    
    for(int i=4; i<25; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 0.0f)];
    }
    
    //top
    for(int i=1; i<25; i++) {
        [self addBrickAt:ccp(i * brickSideLen, 13*brickSideLen)];
    }
    
    //right
    for(int i=1; i<14; i++) {
        [self addBrickAt:ccp(24 * brickSideLen, i*brickSideLen)];
    }
    
    for(int i=5; i<=15; i+=10) {
        [self addObs1At: ccp(5,i)];
        [self addObs2At: ccp(15,i+2)];
        [self addObs1At: ccp(25,i)];
        [self addObs2At: ccp(35,i+2)];
    }
    
    [self addObs2At:ccp(42, 15.5)];
    [self addObs2At:ccp(42, 7.5)];

}

-(void) createTargets {
    int row = 1;
    int col = 1;
    for(int i=4; i<25; i+=2) {
        for(int j=40; j<48; j+=2) {
            if( !( (row==3 || row==4 || row==7 || row==8 ) && (col==2 || col==3) )) {
                [self addCoinAt:ccp(j, i)];
            }
            col++;
        }
        row++;
        col = 1;
    }
    
    for(int i=4; i<20; i+=2) {
        for(int j=20; j<26; j+=2) {
            [self addCoinAt:ccp(j,i)];
        }
    }
    
    for(float i=20; i<25; i+=1.5) {
        for(float j=3; j<6; j+=1.5) {
            [self addCoinAt:ccp(j,i)];
        }
    }
    
    for(float i=23;  i<25; i+=1.5) {
        for(float j=6; j<12; j+=1.5) {
            [self addCoinAt:ccp(j, i)];
        }
    }
    
    for(float i=12; i<17; i+=1.5) {
        [self addCoinAt:ccp(i, 24.5)];
    }

}

-(void) addObs1At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture:obs1Texture];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l2_obs_1_base"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l2_obs_1_base" with:&bodyDef andWith:sprite];
}

-(void) addObs2At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture:obs2Texture];
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
    
    CCSprite *sprite = [CCSprite spriteWithTexture:brickTexture ];	
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    
    [[GameManager sharedInstance] addObstacle:&fixture with:&bodyDef andWith: sprite];
    
}

- (void)dealloc
{
    [brickTexture release];
    brickTexture = nil;
    
    [obs1Texture release];
    obs1Texture = nil;
    
    [obs2Texture release];
    obs2Texture = nil;
    
    [super dealloc];
}
@end
