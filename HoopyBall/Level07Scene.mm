//
//  Level07Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level07Scene {
    
@private
    CGSize size;
}

-(id) init {
    if(self = [super init]) {
        size.width = 1792;
        size.height = 1280;
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level7_bg-hd.tmx" : @"level7_bg.tmx";}

-(CGPoint) getEndPoint {
    return ccp(10, 10);
}

-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    
    //left wall
    for(int i = 2; i < 10;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    [self addBrickAt:ccp(1, 0.0f)];
    [self addBrickAt:ccp(2, 0.0f)];
    
    for(int i=4; i<14; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=1; i<14; i++) {
        [self addBrickAt:ccp(i, 9)];
    }
    
    //right
    for(int i=1; i<9; i++) {
        [self addBrickAt:ccp(13, i)];
    }
    
    [self addObs1At: ccp(5, 5)];
    [self addObs1At: ccp(5, 11.5)];
    [self addObs1At: ccp(9, 14.75)];
    [self addObs1At: ccp(9, 7)];
    
    [self addObs1At: ccp(13, 5)];
    [self addObs1At: ccp(13, 11.5)];
    [self addObs1At: ccp(17, 14.75)];
    [self addObs1At: ccp(17, 7)];
    
    [self addObs1At: ccp(20, 4)];
    [self addObs1At: ccp(20, 9)];
    [self addObs1At: ccp(20, 14)];

}

-(void) createTargets {
    
    for(int i=8; i<18; i+=2) {
        [self addCoinAt:ccp(4, i)];
    }

    [self addCoinAt:ccp(5.5, 16)];
    [self addCoinAt:ccp(7, 16)];
    [self addCoinAt:ccp(8.5, 16)];
    
    [self addCoinAt:ccp(24, 5)];
    [self addCoinAt:ccp(23.5, 8)];
    [self addCoinAt:ccp(24.5, 8)];
    
    for(float i=11; i<18; i+=1.2) {
        [self addCoinAt:ccp(22.8, i)];
        [self addCoinAt:ccp(24, i)];
        [self addCoinAt:ccp(25.2, i)];
    }
    
    for(int i=4; i<18; i+=2) {
        [self addCoinAt:ccp(15.5, i)];
    }
    
}

- (void)dealloc {
    [super dealloc];
}
@end
