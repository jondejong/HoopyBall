//
//  WinLevelLayer.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WinLevelLayer : CCLayer {
    
}

+(WinLevelLayer *) layer;
-(void) handleEndLevel;

@end
