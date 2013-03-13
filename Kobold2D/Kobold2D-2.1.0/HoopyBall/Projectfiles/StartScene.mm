//
//  HelloWorldLayer.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/20/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HoopyBall.h"


// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation StartScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	StartScene *layer = [StartScene node];
	
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
		
        int coins = [[GameManager sharedInstance] totalCoins];
        NSString * coinString =[NSString stringWithFormat:@"Coins: %i", coins];
        
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hoopy Ball" fontName:@"Marker Felt" fontSize:64];
        CCLabelTTF *coinLabel = [CCLabelTTF labelWithString:coinString fontName:@"Marker Felt" fontSize:32];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position = ccp( size.width /2 , size.height/2 + 125);
        coinLabel.position = ccp( size.width /2 , size.height/2 + 70);
		
		// add the label as a child to this Layer
		[self addChild: label];
        [self addChild: coinLabel];
		
		// Default font size will be 28 points.
		[CCMenuItemFont setFontSize:28];

        
        // Level Set 1
		CCMenuItem *level1 = [CCMenuItemFont itemWithString:@"Level 1" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:1];
		}];
	    
        CCMenuItem *level2 = [CCMenuItemFont itemWithString:@"Level 2" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:2];
		}];
        
        CCMenuItem *level3 = [CCMenuItemFont itemWithString:@"Level 3" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:3];
		}];
        
        CCMenuItem *level4 = [CCMenuItemFont itemWithString:@"Level 4" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:4];
		}];
        
        CCMenuItem *level5 = [CCMenuItemFont itemWithString:@"Level 5" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:5];
		}];
        
        CCMenu *menuSet1 = [CCMenu menuWithItems:level1, level2, level3, level4, level5, nil];
		
		[menuSet1 alignItemsHorizontallyWithPadding:20];
		[menuSet1 setPosition:ccp( size.width/2, size.height/2 - 50)];
//		
//		// Add the menu to the layer
		[self addChild:menuSet1];
        
        
        // Level Set 2
        CCMenuItem *level6 = [CCMenuItemFont itemWithString:@"Level 6" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:6];
		}];
	    
        CCMenuItem *level7 = [CCMenuItemFont itemWithString:@"Level 7" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:7];
		}];
        
        CCMenuItem *level8 = [CCMenuItemFont itemWithString:@"Level 8" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:8];
		}];
        
        CCMenuItem *level9 = [CCMenuItemFont itemWithString:@"Level 9" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:9];
		}];
        
        CCMenuItem *level10 = [CCMenuItemFont itemWithString:@"Level 10" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:10];
		}];
        
        CCMenu *menuSet2 = [CCMenu menuWithItems:level6, level7, level8, level9, level10, nil];
		
		[menuSet2 alignItemsHorizontallyWithPadding:20];
		[menuSet2 setPosition:ccp( size.width/2, size.height/2 - 100)];
        //		
        //		// Add the menu to the layer
		[self addChild:menuSet2];
        
        // Level Set 3
        CCMenuItem *level11 = [CCMenuItemFont itemWithString:@"Level 11" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:11];
		}];
	    
        CCMenuItem *level12 = [CCMenuItemFont itemWithString:@"Level 12" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:12];
		}];
        
        CCMenuItem *level13 = [CCMenuItemFont itemWithString:@"Level 13" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:13];
		}];
        
        CCMenuItem *level14 = [CCMenuItemFont itemWithString:@"Level 14" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:14];
		}];
        
        CCMenuItem *level15 = [CCMenuItemFont itemWithString:@"Level 15" block:^(id sender) {
            [[GameManager sharedInstance] handleStartLevel:15];
		}];
        
        CCMenu *menuSet3 = [CCMenu menuWithItems:level11, level12, level13, level14, level15, nil];
		
		[menuSet3 alignItemsHorizontallyWithPadding:20];
		[menuSet3 setPosition:ccp( size.width/2, size.height/2 - 150)];
        //		
        //		// Add the menu to the layer
		[self addChild:menuSet3];

	}
	return self;
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
