//
//  Level12Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level12Scene {
    
@private
    CGSize size;
}

-(id) init {
    if(self = [super init]) {  
        size.width = 1792;
        size.height = 1792;
        
    }
    return self;
}

-(double)secondsBetweenEnemies {return 5;}
-(int) maxEnemies {return 15;}
-(double)secondsBeforeFirstEnemy{return 30;}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level12_bg-hd.tmx" : @"level12_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 7); }
//-(CGPoint) getStartPoint {return ccp(12, 25); }

-(CGPoint) getEndPoint {
    return ccp(23.5, 23);
}

-(CGPoint) getEnemyStartPoint {
    return ccp(5, .5);
}

-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    [self addBrickAt:ccp(0.0f, 1.0f)];
    [self addBrickAt:ccp(0.0f, 2.0f)];
    
    //left wall
    for(int i = 4; i < 14;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    [self addBrickAt:ccp(1, 0)];
    
    for(int i=3; i<14; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=1; i<14; i++) {
        [self addBrickAt:ccp(i, 13)];
    }
    
    //right
    for(int i=1; i<14; i++) {
        [self addBrickAt:ccp(13, i)];
    }
    
    // Routes
    for(int i=12; i>9; i--) {
        [self addBrickAt:ccp(10.5, i)];
    }
    for(int i=9; i>1; i--) {
        [self addBrickAt:ccp(11, i)];
    } 
    
    for(int i=1; i<9; i++) {
        [self addBrickAt:ccp(9, i)];
    }
    
    for(int i=9; i<12; i++) {
        [self addBrickAt:ccp(8.5, i)];
    }
    
    // Other routes
    for(int i=1; i<8; i++) {
        [self addBrickAt:ccp(7, i)];
    }
    
    for(int i=8; i<12; i++) {
        [self addBrickAt:ccp(6.5, i)];
    }
    
    [self addObs1SmallAt:ccp(4, 4)];
    [self addObs2SmallAt:ccp(8, 8)];
    [self addObs1SmallAt:ccp(4, 12)];
    [self addObs2SmallAt:ccp(8, 16)];

}

-(void) createTargets {
    
    float yoffset = 1.5;
    float xoffset = 1.3;
    float x=25;
    float y=22;
    
    for(y=22; y>1; y-=yoffset) {
        [self addCoinAt:ccp(x, y)];
    }
    for(y+=yoffset; x>20; x-=xoffset) {
        [self addCoinAt:ccp(x, y)];
    }
    
    for(x+=xoffset; y<20; y+=yoffset) {
        [self addCoinAt:ccp(x, y)];
    }
    
    y-=yoffset;
    
    for(x-=xoffset; y<26; y+=yoffset) {
        [self addCoinAt:ccp(x, y)];
    }
    
    for(y-=yoffset; x>13; x-=yoffset) {
        [self addCoinAt:ccp(x, y)];
    }
    
    x += (2.75 * xoffset);
    for(y-=yoffset; y>16; y-=yoffset) {
        [self addCoinAt:ccp(x, y)];
    }
    
    x+=xoffset;
    for(y+=yoffset; y>1; y-=yoffset) {
        [self addCoinAt:ccp(x, y)];
    }
    
    float offset = 1.5;
    for(float i = 10; i<14; i+=offset ) {
        for (float j = 3; j<7; j+=offset) {
            [self addCoinAt:ccp(i, j)];
        }
    }
    
}

- (void)dealloc {
    [super dealloc];
}
@end
