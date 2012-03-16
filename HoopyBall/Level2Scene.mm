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

-(CGSize) getCurrentLevelSize { return size; }
-(NSString*) getCurrentBackgroundTMX { return @"bg2.tmx"; }

@end
