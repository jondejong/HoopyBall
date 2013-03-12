//
//  RootNode.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"
#import "PauseLayer.h"

@implementation GamePlayRootNode {
@private

}

enum {
    BackgroundLayerTag,
    GameSceneTag,
    PauseLayerTag,
    ControlLayerTag
};

+(CCScene*) scene {
    return [GamePlayRootNode node];
}

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}


-(void) dealloc 
{
    [super dealloc];    
}


@end
