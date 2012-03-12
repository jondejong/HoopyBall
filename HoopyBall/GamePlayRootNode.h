//
//  RootNode.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"


@interface GamePlayRootNode : CCNode {
    
}


+(GamePlayRootNode *) sharedInstance;
-(void) handlePause;
-(void) handleUnpause;
-(void) handleEndGame;

@end
