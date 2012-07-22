//
//  Level10Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level10Scene {
    
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

-(CGPoint) getEnemyStartPoint {
    return ccp(13, .5);
}

-(int) maxEnemies { return 10;}
-(double) secondsBetweenEnemies { return 30; } 

-(CGPoint) getStartPoint {return ccp(.5, 9); }

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level9_bg-hd.tmx" : @"level9_bg.tmx";}

-(CGPoint) getEndPoint {
    return ccp(25, 25);
}

-(void) createObstacles {
    
    //Start
    for(int i=0; i<4; i++) {
        [self addBrickAt:ccp(0.0f, i)];
    }
        
    //left wall
    for(int i = 5; i < 25;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    for(int i=1; i<6; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    for(int i=7; i<30; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=1; i<30; i++) {
        [self addBrickAt:ccp(i, 24)];
    }
    
    //right
    for(int i=1; i<25; i++) {
        [self addBrickAt:ccp(29, i)];
    }
    
    //Lower left other walls
    for(int i=1; i<4; i++) {
        [self addBrickAt:ccp(5, i)];
    }
    
    for(int i=1; i<4; i++) {
        [self addBrickAt:ccp(i, 3)];
    }
    
    //Upper left other walls
    for(int i=20; i<23; i++) {
        [self addBrickAt:ccp(6, i)];
    }
    
    for(int i=1; i<6; i++) {
        [self addBrickAt:ccp(i, 20)];
    }
    
    // Lower Right Walls
    for(int i=1; i<7; i++){
        [self addBrickAt:ccp(23,i)];
    }
    
    for(int i=23; i<28; i++){
        [self addBrickAt:ccp(i,7)];
    }
    
    //Upper right other walls
    for(int i=25; i>19; i--) {
        [self addBrickAt:ccp(23, i)];
    }
    
    for(int i=23; i<28; i++){
        [self addBrickAt:ccp(i,19)];
    }
    

    // Walls around end point
    for(int i=11; i<14; i++) {
        [self addBrickAt:ccp(10, i)];
    }
    for(int i=11; i<14; i++) {
        [self addBrickAt:ccp(14, i)];
    }
    
    [self addBrickAt:ccp(11, 11)];
    [self addBrickAt:ccp(12, 11)];
    [self addBrickAt:ccp(13, 11)];
    
    [self addBrickAt:ccp(12, 14)];
    [self addBrickAt:ccp(13, 14)];
    [self addBrickAt:ccp(14, 14)];
    
    
    //Obstacles
    [self addObs1At:ccp(4, 10)];
    [self addObs1At:ccp(6, 15)];
    [self addObs1At:ccp(8, 20)];
    [self addObs1At:ccp(10, 25)];
    [self addObs1At:ccp(8, 30)];
    [self addObs1At:ccp(6, 35)];
    
    [self addObs2At:ccp(25, 4)];
    [self addObs2At:ccp(40, 20)];
    
    [self addObs1At:ccp(30, 15)];
    [self addObs1At:ccp(35, 10)];
    [self addObs1At:ccp(42, 15)];
    
    [self addObs1At:ccp(45, 18)];
    [self addObs1At:ccp(50, 23)];
    [self addObs1At:ccp(45, 28)];
    [self addObs1At:ccp(50, 33)];

    
    [self addObs1At:ccp(20, 40)];
    [self addObs1At:ccp(25, 33)];
    [self addObs1At:ccp(30, 40)];
    [self addObs1At:ccp(35, 33)];
    [self addObs1At:ccp(40, 40)];
}

-(void) createTargets {
    float offset = 1.3;
   
    float start = 2.7;
    for(float i=start; i<10; i+=offset) {
        for(float j=start; j<6; j+=offset) {
            [self addCoinAt:ccp(i,j)];
        }
    }
    
    float xMax = 60;
    for(float i=(xMax - start); i>xMax-11; i-=offset) {
        for(float j=start; j<14; j+=offset) {
            [self addCoinAt:ccp(i,j)];
        }
    }
    
    for(float i=start; i<11.5; i+=offset) {
        for(float j=(50-(start +.25)); j>42; j-=offset) {
            [self addCoinAt:ccp(i,j)];
        }
    }
    
    for(float i=(xMax - start); i>xMax-11; i-=offset) {
        for(float j=(50-(start +.25)); j>40; j-=offset) {
            [self addCoinAt:ccp(i,j)];
        }
    }
    
}

- (void)dealloc {
    [super dealloc];
}
@end