//
//  ScoreLayer.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 4/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreLayer.h"
#import "ScreenSize.h"


@implementation ScoreLayer{
    @private
    int score;
    CCLabelBMFont* scoreText;
    
    enum {
        kScoreTextFontTag = 100
    };
    
}

-(id) init {
    if(self = [super init]) {
        scoreText = [CCLabelBMFont labelWithString:@"Score: 0" fntFile:@"score.fnt"];
        score = 0;
        // ask director the the window size
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        scoreText.position =  ccp(size.width - (.2*size.width), size.height - (.1*size.height));
        
        [self addChild: scoreText];
    }
    return self;
}

-(void) addToScore: (int) scoreAddition {
    score += scoreAddition;
    [scoreText setString:[NSString stringWithFormat:@"Coins: %i", score]];
}

-(int) getScore {
    return score;
}

- (void)dealloc
{
    scoreText = nil;
    [super dealloc];
}

@end
