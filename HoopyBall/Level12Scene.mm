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

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"level12_bg-hd.tmx" : @"level12_bg.tmx";}

-(CGPoint) getStartPoint {return ccp(.5, 7); }

-(CGPoint) getEndPoint {
    return ccp(10, 45);
}

-(float) getgetEnemyXSpeed {
    return  0;
}
-(float) getgetEnemyYSpeed {return 4;}

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
    
}

-(void) createTargets {
    

    
    
}

- (void)dealloc {
    [super dealloc];
}
@end
