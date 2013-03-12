//
//  Level13Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level13Scene {
    
@private
    CGSize size;
}

-(id) init {
    if(self = [super init]) {  
        size.width = 2048;
        size.height = 768;
        
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level13_bg-hd.tmx" : @"level13_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 9); }

-(CGPoint) getEndPoint {
    return ccp(25, 7);
}

-(CGPoint) getEnemyStartPoint {
    return ccp(5, .5);
}

-(int) maxEnemies {
    return 2;
}

-(double) secondsBeforeFirstEnemy { return 20; }

-(double) secondsBetweenEnemies {
    return 10;
}

-(void) createObstacles {
    
    //left wall
    for(int i = 0; i < 4;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    [self addBrickAt:ccp(1, 0)];
    
    for(int i=3; i<16; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=0; i<15; i++) {
        [self addBrickAt:ccp(i, 5)];
    }
    
    //right
    for(int i=1; i<6; i++) {
        [self addBrickAt:ccp(15, i)];
    }
    
    // Block Wall
    float bloackWallStart = 20.0;
    [self addObs1SmallAt:ccp(bloackWallStart, 6.6)];
    [self addObs1SmallAt:ccp(bloackWallStart+1, 5.0)];
    [self addObs1SmallAt:ccp(bloackWallStart+2, 3.4)];
    
    
    [self addObs1SmallAt:ccp(8.25, 2.5)];
    [self addObs2SmallAt:ccp(14.0, 2.5)];
}


-(void) createTargets {
    
    float baseX = 10.7;
    for(float x=baseX; x<baseX + 5.5; x+=1.25) {
        [self addCoinAt:ccp(x, 2.5)];
    }
    
    baseX += .6;
    for(float x=baseX; x<baseX + 4; x+=1.25) {
        [self addCoinAt:ccp(x, 3.5)];
    }

    baseX = 26.75;
    float y = 3;
    
    for(float x=baseX; x<=baseX + 3; x+=1.25) {
        for(; y<=6; y+=1.25) {
            CCLOG(@"Adding coin at %f %f", x, y);
            [self addCoinAt:ccp(x, y)];
        }
    }
    
    for(float x=baseX+1.25; x<=baseX + 3; x+= 1.25) {
        for(float newY = y; newY <= y+2.5; newY+=1.25) {
            [self addCoinAt:ccp(x, newY)];
        }
    }
    
    
    
}

- (void)dealloc {
    [super dealloc];
}
@end
