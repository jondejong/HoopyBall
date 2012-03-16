//
//  PauseLayer.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PauseLayer.h"
#import "GameManager.h"

@implementation PauseLayer

+(PauseLayer *) layer
{
    return [PauseLayer node];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        // create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Pause" fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		label.position =  ccp(size.width/2, size.height/2);
        
        CCSprite *fader = [CCSprite spriteWithFile:@"fader.png"];
        fader.anchorPoint = ccp(0,0);
        fader.position = ccp(0,0);
        [self addChild: fader];
        
		// add the label as a child to this Layer
		[self addChild: label];
        
        // Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];
        
		CCMenuItem *resume = [CCMenuItemFont itemWithString:@"Resume Game" target:self selector:@selector(handleUnpause)];
        CCMenuItem *endGame = [CCMenuItemFont itemWithString:@"End Level" target:self selector:@selector(handleEndLevel)];
        
        CCMenu *menu = [CCMenu menuWithItems:resume, endGame, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		[self addChild:menu];
        
    }
    return self;
}

-(void) handleEndLevel
{
    [[GameManager sharedInstance] handleEndLevel];
}

-(void) handleUnpause
{
     [[GameManager sharedInstance] handleUnpause];  
}

-(void) dealloc
{
    [super dealloc];
}

@end
