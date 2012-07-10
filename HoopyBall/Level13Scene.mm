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
    return ccp(10, 45);
}

-(CGPoint) getEnemyStartPoint {
    return ccp(5, .5);
}

-(float) getgetEnemyXSpeed {
    return  0;
}
-(float) getgetEnemyYSpeed {return 4;}

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
}

-(void) createTargets {

    
}

- (void)dealloc {
    [super dealloc];
}
@end
