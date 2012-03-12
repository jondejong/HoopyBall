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

enum {
    kTileMap = 1
};

@implementation BackgroundLayer {
    
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        //Set up pause layer
          
        // create and initialize a Label
//		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap the screen..." fontName:@"Marker Felt" fontSize:64];
        
		// ask director the the window size
//		CGSize size = [[CCDirector sharedDirector] winSize];
        
//        double offset = size.height/4;
//		label.position = ccp(size.width/2, size.height/2 + offset);
        
        // background
//        CCSprite* bground = [CCSprite spriteWithFile:@"scene_1.png"];
//        bground.position=ccp(0,0);
//        bground.anchorPoint=ccp(0,0);
//
//        [self addChild:bground];
        
		// add the label as a child to this Layer
//		[self addChild: label];

        
        [self addChild:[CCTMXTiledMap tiledMapWithTMXFile:@"bg.tmx"] z:1 tag:kTileMap];
		
        
    }
    return self;
}

//-(void) updateBGPosition: (CGPoint) p {
//    bool update = false;
//    
//    CGSize ls = [[GameScene sharedInstance] getCurrentLevelSize];
//    CGPoint bgp = [self getChildByTag:kTileMap].position;
//    CGSize screenSize = [[CCDirector sharedDirector] winSize];
//    
//    // Max from
//    float yMaxFromEdge = screenSize.height / 3;
//    float xMaxFromEdge = screenSize.width / 3;
//    
//    float xmove = 0;
//    float ymove = 0;
//    
//    if(p.x > bgp.x + screenSize.width - xMaxFromEdge) {
//        float rightScreenX = (bgp.x + screenSize.width);
//        xmove = rightScreenX - p.x;
//        update = true;
//    }
//    
//    if(p.y > bgp.y + screenSize.height - yMaxFromEdge) {
//        ymove = (bgp.y + screenSize.height) - p.y;
//        update = true;
//    }
//    
//    if(update) {
//        [[self getChildByTag:kTileMap] setPosition:ccp(bgp.x - xmove, bgp.y - ymove)];
//    }
//    
//    // max positions
////    int mh = ls.height - hd;
////    int mw = ls.width - wd;
////    
////    int xmove = 0;
////    int ymove = 0;
////    
////    if(p.x > mh) {
////        xmove = 
////    }
//}

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
