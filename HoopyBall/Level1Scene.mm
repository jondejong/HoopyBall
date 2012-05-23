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
#import "PhysicsSprite.h"

@implementation Level1Scene {
    @private
    CCTexture2D* coinTexture;
    CCTexture2D* borderTexture;

    enum {
        kCoinParentTag = 1,
        kBorderParentNode = 2
    };

}

float height = 768.0;
float width = 1024.0;

float defaultBorderTileSize = 2.0 * PTM_RATIO;


-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {

        height *= [ScreenSize multiplier];
        width *= [ScreenSize multiplier];

        CCSpriteBatchNode *coin = [CCSpriteBatchNode batchNodeWithFile:@"smiley.png" capacity:100];
        coinTexture = [coin texture];
        [self addChild:coin z:0 tag: kCoinParentTag];
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"border1_shapes.plist"];
        
    }
    return self;
} 

-(CGPoint) getStartPoint {
    CGPoint p = ccp(4.0 * PTM_RATIO, 4.0 * PTM_RATIO);
    return p;
}

-(CGSize) getLevelSize {
    CGSize s;
    s.height = height;
    s.width = width;
    return s;
}

-(NSString*) getBackgroundTMX {
    return [ScreenSize isRetina] ? @"level1_bg-hd.tmx" : @"level1_bg.tmx";
}

-(CGPoint) getEndPoint {
    return ccp(9 * PTM_RATIO, 5 * PTM_RATIO);
}

-(CGPoint) getBadGuyStartPoint {
    return ccp(12 * PTM_RATIO, 2 * PTM_RATIO);
}
-(float) getBadGuyXSpeed {return -4;}
-(float) getBadGuyYSpeed {return 1;}

-(int) getBadGuyFrequency {return 500;}

-(void) createObstacles {   
    
    // Bottom
    [self addBorder:@"Level1_13" at: ccp(0.0f, 0.0f)];
    [self addBorder:@"Level1_14" at: ccp(2* defaultBorderTileSize, 0.0f)];
    [self addBorder:@"Level1_15" at: ccp(4* defaultBorderTileSize, 0.0f)];
    [self addBorder:@"Level1_10" at: ccp(2* defaultBorderTileSize, defaultBorderTileSize)];
    [self addBorder:@"Level1_11" at: ccp(4* defaultBorderTileSize, defaultBorderTileSize)];
    
    //Left
    [self addBorder:@"Level1_09" at: ccp(0.0f, defaultBorderTileSize)];
    [self addBorder:@"Level1_07" at: ccp(0.0f, 2 * defaultBorderTileSize)];
    [self addBorder:@"Level1_05" at: ccp(0.0f, 3 * defaultBorderTileSize)];
    [self addBorder:@"Level1_03" at: ccp(0.0f, 4 * defaultBorderTileSize)];
    
    //Top
    [self addBorder:@"Level1_01" at: ccp(0.0f, 5 * defaultBorderTileSize)];
    [self addBorder:@"Level1_02" at: ccp(4 * defaultBorderTileSize, 5 * defaultBorderTileSize)];
    
    //Right
    [self addBorder:@"Level1_04" at: ccp(4 * defaultBorderTileSize, 4 * defaultBorderTileSize)];
    [self addBorder:@"Level1_06" at: ccp(4 * defaultBorderTileSize, 3 * defaultBorderTileSize)];
    [self addBorder:@"Level1_08" at: ccp(4 * defaultBorderTileSize, 2 * defaultBorderTileSize)];
    [self addBorder:@"Level1_12" at: ccp(6 * defaultBorderTileSize, defaultBorderTileSize)];
}

-(void) addBorder: (NSString*) name at: (CGPoint) p {
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);

    [[GameManager sharedInstance] addCachedObstacle:name with:&bodyDef ];
    
}

-(void) createTargets {
  
    for(int i=4; i<14; i+=2) {
        [self addCoinAt:ccp(i, 9.5f)];
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
