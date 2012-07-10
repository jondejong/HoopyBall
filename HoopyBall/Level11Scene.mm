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
        size.width = 1024;
        size.height = 6400;
        
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"l3_bg-hd.tmx" : @"l3_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 3); }

-(CGPoint) getEndPoint {
    return ccp(10, 45);
}

-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    
    //left wall
    for(int i = 2; i < 50;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    for(int i=0; i<6; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    [self addBrickAt:ccp(7.0f, 0.0f)];
    
    //top
    for(int i=1; i<8; i++) {
        [self addBrickAt:ccp(i, 49)];
    }
    
    //right
    for(int i=1; i<50; i++) {
        [self addBrickAt:ccp(7, i)];
    }
    
    [self addObs1At: ccp(3,2)];
    [self addObs1At: ccp(2,10)];
    [self addObs2At: ccp(4,20)];
    
    [self addObs1At: ccp(2,30)];
    [self addObs2At: ccp(4,40)];
    
    [self addObs1At: ccp(2,50)];
    [self addObs2At: ccp(4,60)];
    
}

-(void) createTargets {
    
    [self addCoinAt:ccp(2.5f, 12.0f)];
    [self addCoinAt:ccp(3.0f, 13.0f)];
    [self addCoinAt:ccp(3.5f, 14.0f)];
    
    [self addCoinAt:ccp(2.5f, 32.0f)];
    [self addCoinAt:ccp(3.0f, 33.0f)];
    [self addCoinAt:ccp(3.5f, 34.0f)];
    
    [self addCoinAt:ccp(12.5f, 22.0f)];
    [self addCoinAt:ccp(12.0f, 23.0f)];
    [self addCoinAt:ccp(11.5f, 24.0f)];
    
    [self addCoinAt:ccp(12.5f, 42.0f)];
    [self addCoinAt:ccp(12.0f, 43.0f)];
    [self addCoinAt:ccp(11.5f, 44.0f)];
    
    [self addCoinAt:ccp(2.5f, 52.0f)];
    [self addCoinAt:ccp(3.0f, 53.0f)];
    [self addCoinAt:ccp(3.5f, 54.0f)];
    
    [self addCoinAt:ccp(12.5f, 62.0f)];
    [self addCoinAt:ccp(12.0f, 63.0f)];
    [self addCoinAt:ccp(11.5f, 64.0f)];
    
    // Top blob
    for(int i=3; i<15; i+=2) {
        for(int j=70; j<97; j+=2){
            [self addCoinAt:ccp(i, j)];
        }
    }
    
    
}

- (void)dealloc {
    [super dealloc];
}
@end
