//
//  GameScene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HBLevel.h"
#import "GameManager.h"
#import "Constants.h"
#import "GB2ShapeCache.h"
#import "HBUserData.h"


@implementation Level1Scene {
    @private
    CCTexture2D* coinTexture;

    enum {
        kCoinParentTag = 1
    };

}

float height = 0.0;
float width = 0.0;


-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {

        
#if USE_LARGE_WORLD
        height = 2048 * [ScreenSize multiplier];
        width = 4096 * [ScreenSize multiplier];
//        height = 1000;
//        width = 1400;
#else
        height = [[CCDirector sharedDirector] winSize].height;
        width = [[CCDirector sharedDirector] winSize].width;
#endif
        CCSpriteBatchNode *coin = [CCSpriteBatchNode batchNodeWithFile:@"smiley.png" capacity:100];
        coinTexture = [coin texture];
        [self addChild:coin z:0 tag: kCoinParentTag];
        
    }
    return self;
} 

-(CGSize) getLevelSize {
    CGSize s;
    s.height = height;
    s.width = width;
    return s;
}

-(NSString*) getBackgroundTMX {
    return [ScreenSize isRetina] ? @"bg-hd.tmx" : @"bg.tmx";
}

-(CGPoint) getEndPoint {
    return ccp(6 * PTM_RATIO, 6 *PTM_RATIO);
}

-(CGPoint) getBadGuyStartPoint {
    return ccp(12 * PTM_RATIO, PTM_RATIO);
}
-(float) getBadGuyXSpeed {return -4;}
-(float) getBadGuyYSpeed {return 1;}

-(int) getBadGuyFrequency {return 500;}

-(void) createObstacles {    
}

-(void) createTargets {
  
    for(int i=3; i<6;i++) {
        [self addCoinAt:ccp(i,i + 7)];
        [self addCoinAt:ccp(i+20,i + 7)];
    }
    
    for(int i=11; i<14;i++) {
        [self addCoinAt:ccp(i,i-1)];
        [self addCoinAt:ccp(i+20, i-1)];
    }
    
    for(int i=3; i<6;i++) {
        [self addCoinAt:ccp(i, i+14)];
        [self addCoinAt:ccp(i+20, i+14)];
    }
    
    for(int i=11; i<14;i++) {
        [self addCoinAt:ccp(i,i+6)];
        [self addCoinAt:ccp(i+20, i+6)];
    }
    
}

-(void) addCoinAt: (CGPoint) p {
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(p.x, p.y);
    
    CoinUserData* data = [CoinUserData node];
    [self addChild:data];
    bodyDef.userData = data;
    
    b2CircleShape coinShape;
    coinShape.m_radius = .5f;
    b2FixtureDef coinFixture;
    coinFixture.shape = &coinShape;
    coinFixture.density = 0.0f;
    coinFixture.friction = 0.0f;
    coinFixture.restitution = 0.0;
    coinFixture.isSensor = true;
    
    CCSprite *sprite = [CCSprite spriteWithTexture:coinTexture];	
    sprite.position = ccp(p.x * PTM_RATIO, p.y * PTM_RATIO);
    [data setSprite:sprite];
    
    [[GameManager sharedInstance] addObstacle:&coinFixture with:&bodyDef andWith: sprite];
}

-(void) dealloc 
{
    [super dealloc];    
}

@end
