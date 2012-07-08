//
//  GameScene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HBLevel.h"
#import "HoopyBall.h"
#import "GB2ShapeCache.h"
#import "HBUserData.h"
#import "PhysicsSprite.h"
#import "ScreenSize.h"

@implementation Level04Scene {
@private
    float height;
    float width;
    
    float startX;
    float startY;
    
    float defaultBorderTileSize;
    enum {
        kBorderParentNode = 2
    };
    
}

-(id) init
{
	if( (self=[super init])) {
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"border1_shapes.plist"];
        
        height = 768.0;
        width = 1024.0;
        
        startX = 0.6f;
        startY = 3.55f;
        
        defaultBorderTileSize = 128.0f;
    }
    return self;
} 

-(CGPoint) getStartPoint {
    CGPoint p = ccp(startX, startY);
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

-(NSString*) getObsTMX {
    return [ScreenSize isRetina] ? @"level1_obs-hd.tmx" : @"level1_obs.tmx";
}

-(CGPoint) getEndPoint {
    return ccp(9, 5);
}

-(CGPoint) getBadGuyStartPoint {
    return ccp(3.5, .5);
}
-(float) getBadGuyXSpeed {return 0;}
-(float) getBadGuyYSpeed {return 3;}

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

-(void) dealloc 
{
    [super dealloc];    
}

@end
