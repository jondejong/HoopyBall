//
//  StartLevelLayer.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 5/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "StartLevelLayer.h"
#import "ScreenSize.h"

@implementation StartLevelLayer

+(StartLevelLayer *) layer
{
    return [StartLevelLayer node];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        // create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap Screen To Start" fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		label.position =  ccp(size.width/2, size.height/2);
        
        //        CCSprite *fader = [CCSprite spriteWithFile:@"fader.png"];
        NSString* fader = [ScreenSize isRetina] ? @"fader-hd.tmx" : @"fader.tmx";
        [self addChild:[CCTMXTiledMap tiledMapWithTMXFile:fader] z:0];
        
		// add the label as a child to this Layer
		[self addChild: label];
        
    }
    return self;
}


@end
