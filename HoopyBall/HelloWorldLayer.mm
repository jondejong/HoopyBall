//
//  HelloWorldLayer.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/20/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
//#import "GameLayer.h"
#import "GameScene.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "BoxLayer.h"


#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Jonny Awesomesauce's Hoopy Ball" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];

		CCMenuItem *start = [CCMenuItemFont itemWithString:@"Start Game" block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene: [GameScene node]];
		}
									   ];
	
//        CCMenuItem *start = [CCMenuItemFont itemWithString:@"Start Game" block:^(id sender) {
//            [[CCDirector sharedDirector] replaceScene: [BoxLayer scene]];
//		}];
        
        CCMenu *menu = [CCMenu menuWithItems:start, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
//		
//		// Add the menu to the layer
		[self addChild:menu];

	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
