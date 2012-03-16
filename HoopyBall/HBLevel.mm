//
//  LBLevel.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HBLevel.h"
#import "Constants.h"

@implementation HBLevel

-(CGSize) getLevelSize {
    CGSize retVal;
    return retVal;
}
-(NSString*) getBackgroundTMX {
    return @"";
}

-(CGPoint) getStartPoint {
    CGPoint p = ccp(0.0f, PTM_RATIO);
    return p;
}
@end
