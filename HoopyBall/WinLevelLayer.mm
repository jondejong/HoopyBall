//
//  WinLevelLayer.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"

#import "WinLevelLayer.h"
#import "ScreenSize.h"


@implementation WinLevelLayer

+(WinLevelLayer*) layer {
    return [WinLevelLayer node];
}

-(id) init {
    if(self = [super init]) {
        // create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"By Golly, It Appears You Won" fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		label.position =  ccp(size.width/2, size.height - (size.height/3));
        
        //        CCSprite *fader = [CCSprite spriteWithFile:@"fader.png"];
        NSString* fader = [ScreenSize isRetina] ? @"fader-hd.tmx" : @"fader.tmx";
        [self addChild:[CCTMXTiledMap tiledMapWithTMXFile:fader] z:0];
        //        fader.anchorPoint = ccp(0,0);
        //        fader.position = ccp(0,0);
        //        [self addChild: fader];
        
		// add the label as a child to this Layer
		[self addChild: label];
        
        // Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
        
        CCMenuItem *endGame = [CCMenuItemFont itemWithString:@"End Level" target:self selector:@selector(handleEndLevel)];
        
        CCMenu *menu = [CCMenu menuWithItems:endGame, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2) ];
		[self addChild:menu];
    }
    return self;
}

-(void) handleEndLevel {
    [[GameManager sharedInstance] handleEndLevel];
}

-(void) displayScore: (int) score {
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d", score] fontName:@"Marker Felt" fontSize:48];
    CGSize size = [[CCDirector sharedDirector] winSize];
    label.position =  ccp(size.width/2, size.height - ((2*size.height)/5));
    [self addChild: label];
}

@end
