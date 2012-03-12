//
//  GoodGuy.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GoodGuy.h"


@implementation GoodGuy

-(id) initInWord:(b2World*)world {
//    NSAssert(world != NULL, @"world is null!"); NSAssert(shapeName != nil, @"name is nil!");
    // init the sprite itself with the given shape name self = [super initWithSpriteFrameName:shapeName]; if (self)
    if(self = [super init]){
        // create the body
        b2BodyDef bodyDef;
//        body = world->CreateBody(&bodyDef); body->SetUserData(self);
//        
//        GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache]; 
//        [shapeCache addFixturesToBody:ballBody forShapeName:@"hb_guy"];
//        
//        // set the shape
//        [self setBodyShape:shapeName]; 
    }
    return self;
}

@end
