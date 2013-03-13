//
//  Level06Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"
#import "GB2ShapeCache.h"

@implementation Level06Scene {
    
@private
    CGSize size;
}

-(id) init {
    if(self = [super init]) {
        size.width = 1280;
        size.height = 1280;
                
    }
    return self;
}

-(double)secondsBetweenEnemies {return 30;}
-(int) maxEnemies {return 1;}
                                               
-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level6_bg-hd.tmx" : @"level6_bg.tmx";}

-(CGPoint) getEndPoint {
    return ccp(5, 10);
}


-(void) createObstacles {
    //Start
    [self addBrickAt:ccp(0.0f, 0.0f)];
    
    //left wall
    for(int i = 2; i < 11;  i++){
        [self addBrickAt: ccp(0.0f, i)];
    }
    
    //bottom
    [self addBrickAt:ccp(1, 0.0f)];
    [self addBrickAt:ccp(2, 0.0f)];
    
    for(int i=4; i<10; i++) {
        [self addBrickAt:ccp(i, 0.0f)];
    }
    
    //top
    for(int i=1; i<10; i++) {
        [self addBrickAt:ccp(i, 9)];
    }
    
    //right
    for(int i=1; i<9; i++) {
        [self addBrickAt:ccp(9, i)];
    }
    
    [self addObs1At: ccp(5,5)];
    [self addObs1At: ccp(5, 14.75)];
    [self addObs1At: ccp(9, 11.5)];
    [self addObs1At: ccp(9, 7)];;
    
}

-(void) createTargets {
    
    for(int i=8; i<18; i+=2) {
        [self addCoinAt:ccp(4, i)];
    }
    
    for(float i=10; i<17; i+=1.5) {
        [self addCoinAt:ccp(14, i)];
        [self addCoinAt:ccp(16, i)];
    }

}

@end
