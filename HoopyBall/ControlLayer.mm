//
//  ControlLayer.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ControlLayer.h"
#import "GameScene.h"
#import "GamePlayRootNode.h"

CCMenuItemSprite *pauseButton;

@implementation ControlLayer

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        //Set up pause layer

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        double offset = size.height/4;
        
        CCSprite* pauseSprite = [CCSprite spriteWithFile:@"pause.png"];
        CCSprite* pauseSpriteSelected = [CCSprite spriteWithFile:@"pause.png"];
        
        pauseButton = [CCMenuItemSprite itemWithNormalSprite:pauseSprite selectedSprite:pauseSpriteSelected target:self selector:@selector(handlePause)];
        
		CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
        
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp(0 + offset/2, 0 + offset/2)];

        [self addChild:menu];
		
    }
    return self;
}


-(void) handlePause 
{
    [pauseButton setIsEnabled: false];
    [[GamePlayRootNode sharedInstance] handlePause];
}

-(void) handleUnpause
{
    [pauseButton setIsEnabled:true];
}

@end
