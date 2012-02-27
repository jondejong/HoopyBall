//
//  GameLayer.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"
#import "PauseLayer.h"
#import "GameScene.h"

@implementation BackgroundLayer 

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        //Set up pause layer
          
        // create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap the screen..." fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        double offset = size.height/4;
		label.position = ccp(size.width/2, size.height/2 + offset);
        
        // background
        CCSprite* bground = [CCSprite spriteWithFile:@"scene_1.png"];
        bground.position=ccp(0,0);
        bground.anchorPoint=ccp(0,0);

        [self addChild:bground];
        
		// add the label as a child to this Layer
		[self addChild: label];
		
    }
    return self;
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
//    [pauseButton release];
	[super dealloc];
}

@end
