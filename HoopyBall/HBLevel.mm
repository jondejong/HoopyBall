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

-(NSString*) getObsTMX {
    return nil;
}

-(CGPoint) getStartPoint {
    CGPoint p = ccp(0.0f, PTM_RATIO);
    return p;
}

-(CGPoint) getEndPoint {
    return ccp([ScreenSize screenSize].width, [ScreenSize screenSize].height);
}

-(CGPoint) getBadGuyStartPoint {
    return ccp(-1000, -1000);
}

-(float) getBadGuyXSpeed {return 0;}
-(float) getBadGuyYSpeed {return 0;}

-(int) getBadGuyFrequency {return 10000;}

-(void) createObstacles{}
-(void) createTargets{}

@end
