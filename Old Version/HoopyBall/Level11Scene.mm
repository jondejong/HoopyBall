//
//  Level11Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level11Scene {
    
@private
    CGSize size;
}

-(id) init {
    if(self = [super init]) {  
        size.width = 1536;
        size.height = 1536;
        
    }
    return self;
}

-(double)secondsBetweenEnemies {return 5;}
-(int) maxEnemies {return 3;}
-(double)secondsBeforeFirstEnemy{return 10;}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level11_bg-hd.tmx" : @"level11_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 5); }

-(CGPoint) getEndPoint {
    return ccp(3, 18.5);
}

-(CGPoint) getEnemyStartPoint {
    return ccp(5, .5);
}

-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    [self addBrickAt:ccp(0.0f, 1.0f)];
    
    //left wall
    for(int i = 3; i < 12;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    [self addBrickAt:ccp(1, 0)];
    
    for(int i=3; i<12; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=1; i<12; i++) {
        [self addBrickAt:ccp(i, 11)];
    }
    
    //right
    for(int i=1; i<12; i++) {
        [self addBrickAt:ccp(11, i)];
    }
    
    [self addObs1SmallAt:ccp(7, 2)];
    [self addObs2SmallAt:ccp(7, 8)];
    [self addObs1SmallAt:ccp(7, 16)];
    
    [self addObs2SmallAt:ccp(15, 2)];
    [self addObs1SmallAt:ccp(15, 8)];
    [self addObs2SmallAt:ccp(15, 16)];

}

-(void) createTargets {
    float offset = 1.4;
    float xStart = 9.5;
    
    for(float x = 1; x<6; x++) {
        float newx = (xStart + (x * offset));
        [self addCoinAt:ccp(newx, 2.5)];
    }

    xStart = 18.25;
    float yStart = 2.5 - offset;
    
    for(float x = 1; x<3; x++) {
        for(float y = 1; y<15; y++) {
            float newx = xStart + (x * offset);
            float newy = yStart + (y * offset);
            [self addCoinAt:ccp(newx, newy)];
        }
    }
    
    xStart = 9.5;
    yStart = 9.0;
    
    for(float x=1; x<5; x++) {
        for(float y=1; y<7; y++) {
            float newx = xStart + (x * offset);
            float newy = yStart + (y * offset);
            [self addCoinAt:ccp(newx, newy)];
        }
    }
    
}

- (void)dealloc {
    [super dealloc];
}
@end
