//
//  Level09Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level09Scene {
    
@private
    CGSize size;
}

-(id) init {
    if(self = [super init]) {
        size.width = 3840;
        size.height = 3200;
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level9_bg-hd.tmx" : @"level9_bg.tmx";}

-(CGPoint) getEndPoint {
    return ccp(20, 20);
}

-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    
    //left wall
    for(int i = 2; i < 25;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    [self addBrickAt:ccp(1, 0.0f)];
    [self addBrickAt:ccp(2, 0.0f)];
    
    for(int i=4; i<30; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=1; i<30; i++) {
        [self addBrickAt:ccp(i, 24)];
    }
    
    //right
    for(int i=1; i<29; i++) {
        [self addBrickAt:ccp(29, i)];
    }
    
    [self addObs2At: ccp(5,5)];
    [self addObs2At: ccp(5, 15)];
    [self addObs2At: ccp(5, 25)];
    [self addObs2At: ccp(5, 35)];
    
    [self addObs2At: ccp(15, 5)];
    [self addObs2At: ccp(15, 15)];
    [self addObs2At: ccp(15, 25)];
    [self addObs2At: ccp(15, 35)];
    
    [self addObs2At: ccp(25, 5)];
    [self addObs2At: ccp(25, 15)];
    [self addObs2At: ccp(25, 25)];
    [self addObs2At: ccp(25, 35)];
    
    [self addObs2At: ccp(35, 5)];
    [self addObs2At: ccp(35, 15)];
    [self addObs2At: ccp(35, 25)];
    [self addObs2At: ccp(35, 35)];
    
}

-(void) createTargets {
    
    for(int i=9; i<46; i+=2) {
        [self addCoinAt:ccp(4, i)];
    }
    
    for(int i=9; i<46; i+=2) {
        [self addCoinAt:ccp(50, i)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 45)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 43)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 41)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 39)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 37)];
    }
    for(int i=48; i>40; i-=2) {
        [self addCoinAt:ccp(i, 35)];
    }
    
}

- (void)dealloc {
    [super dealloc];
}
@end
