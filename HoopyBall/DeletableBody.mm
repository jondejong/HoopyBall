//
//  DeletableBody.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"
#import "Box2D.h"

@implementation DeletableBody {
    @private    
    b2Body* body;
}

-(id) initWithBody: (b2Body*)_body {
    if(self = [super init]) {
        body = _body;
        //        sprite = _sprite;
    }
    return self;
}

-(b2Body*) body {
    return body;
}

-(void) setBody: (b2Body*) _body{
    body = _body;
}

- (void)dealloc
{
    body = nil;
    [super dealloc];
}

@end
