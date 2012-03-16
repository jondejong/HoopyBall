//
//  Level2Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HBLevel.h"

@implementation Level2Scene

CGSize size;

-(id) init {
    if(self = [super init]) {
        size.height = 4096;
        size.width = 2048;
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return @"bg2.tmx"; }
-(CGPoint) getStartPoint {return ccp(0.0f, 256.0f); }

@end
