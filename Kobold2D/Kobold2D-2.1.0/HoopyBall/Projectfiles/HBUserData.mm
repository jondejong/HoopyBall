//
//  HBUserData.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HBUserData.h"


@implementation HBUserData

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) handleCollisionBetween : (b2Body *)thisBody with : (HBUserData*) otherBody{}
-(int) nodeType {return -1;}

@end
