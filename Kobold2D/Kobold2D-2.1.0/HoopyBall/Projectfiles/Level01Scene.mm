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
#import "ScreenSize.h"

@implementation Level01Scene {
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

-(id) init {
	if( (self=[super init])) {
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"border1_shapes.plist"];
        
        height = 768.0;
        width = 1024.0;
        
        startX = 0.6f;
        startY = 3.0f;
        
        defaultBorderTileSize = 128.0f;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"level1obs.plist"];
        CCSpriteBatchNode *goodiesSpriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"level1obs.png"];
        [self addChild:goodiesSpriteSheet z:OBSTACLE_Z tag:kObsTag];
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

-(CGPoint) getEndPoint {
    return ccp(9, 5);
}

-(CGPoint) getEnemyStartPoint {
    return ccp(3.5, .5);
}
-(float) getEnemyXSpeed {return 0;}
-(float) getEnemyYSpeed {return 3;}

-(void) createObstacles {
    
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    
    //left wall
    for(int i = 2; i < 6;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom    
    for(int i=2; i<7; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=1; i<8; i++) {
        [self addBrickAt:ccp(i, 5)];
    }
    
    //right
    for(int i=0; i<6; i++) {
        [self addBrickAt:ccp(7, i)];
    }

}

-(void) createTargets {
  
    for(int i=4; i<14; i+=2) {
        [self addCoinAt:ccp(i, 9.25f)];
    }

}

@end
