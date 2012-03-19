//
//  Level2Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HBLevel.h"
#import "Constants.h"

@implementation Level2Scene

CGSize size;

-(id) init {
    if(self = [super init]) {
        size.height = 4096 * [ScreenSize multiplier];
        size.width = 2048 * [ScreenSize multiplier];
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"bg2-hd.tmx" : @"bg2.tmx";}
-(CGPoint) getStartPoint {return ccp(0.0f, 256.0f); }

-(CGPoint) getEndPoint {
    return ccp(10 * PTM_RATIO, 12 *PTM_RATIO);
}

@end
