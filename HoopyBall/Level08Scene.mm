//
//  Level08Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level08Scene {
    
@private
    CGSize size;
}

-(id) init {
    if(self = [super init]) {
        size.width = 3200;
        size.height = 1792;
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level8_bg-hd.tmx" : @"level8_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 3); }

-(CGPoint) getEndPoint {
    return ccp(20, 20);
}

-(CGPoint) getgetEnemyStartPoint {
    return ccp(7, .5);
}

-(float) getgetEnemyXSpeed {
    return  0;
}
-(float) getgetEnemyYSpeed {return 4;}

-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    
    //left wall
    for(int i = 2; i < 14;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    [self addBrickAt:ccp(1, 0.0f)];
    [self addBrickAt:ccp(2, 0.0f)];
    
    for(int i=4; i<25; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=1; i<25; i++) {
        [self addBrickAt:ccp(i, 13)];
    }
    
    //right
    for(int i=1; i<14; i++) {
        [self addBrickAt:ccp(24, i)];
    }
    
    for(int i=5; i<=15; i+=10) {
        [self addObs1At: ccp(5,i)];
        [self addObs2At: ccp(15,i+2)];
        [self addObs1At: ccp(25,i)];
        [self addObs2At: ccp(35,i+2)];
    }
    
    [self addObs2At:ccp(42, 15.5)];
    [self addObs2At:ccp(42, 7.5)];

}

-(void) createTargets {
    int row = 1;
    int col = 1;
    for(int i=4; i<25; i+=2) {
        for(int j=40; j<48; j+=2) {
            if( !( (row==3 || row==4 || row==7 || row==8 ) && (col==2 || col==3) )) {
                [self addCoinAt:ccp(j, i)];
            }
            col++;
        }
        row++;
        col = 1;
    }
    
    for(int i=4; i<20; i+=2) {
        for(int j=20; j<26; j+=2) {
            [self addCoinAt:ccp(j,i)];
        }
    }
    
    for(float i=20; i<25; i+=1.5) {
        for(float j=3; j<6; j+=1.5) {
            [self addCoinAt:ccp(j,i)];
        }
    }
    
    for(float i=23;  i<25; i+=1.5) {
        for(float j=6; j<12; j+=1.5) {
            [self addCoinAt:ccp(j, i)];
        }
    }
    
    for(float i=12; i<17; i+=1.5) {
        [self addCoinAt:ccp(i, 24.5)];
    }

}

- (void)dealloc {
    [super dealloc];
}
@end
