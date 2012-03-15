//
//  GameScene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Level1Scene.h"

#import "PauseLayer.h"
#import "ControlLayer.h"
#import "GameLayer.h"
#import "BoxLayer.h"
#import "Support/ccCArray.h"
#import "DeletableBody.h"
#import "Constants.h"
#import "GB2ShapeCache.h"

@implementation Level1Scene {
    

}

float height = 0.0;
float width = 0.0;


enum {
    BackgroundLayerTag = 1,
    PauseLayerTag = 2,
    ControlLayerTag = 3,
    GameLayerTag = 4
};
 
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {

        
#if USE_LARGE_WORLD
        height = 2048;
        width = 4096;
//        height = 1000;
//        width = 1400;
#else
        height = [[CCDirector sharedDirector] winSize].height;
        width = [[CCDirector sharedDirector] winSize].width;
#endif
        
        
    }
    return self;
} 

-(CGSize) getCurrentLevelSize {
    CGSize s;
    s.height = height;
    s.width = width;
    return s;
}

-(NSString*) getCurrentBackgroundTMX {
    return @"bg.tmx";
}



-(void) dealloc 
{
    [super dealloc];    
}

@end
