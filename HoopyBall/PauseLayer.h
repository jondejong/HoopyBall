//
//  PauseLayer.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PauseLayer : CCLayerColor {
    
}

+(PauseLayer *) layer;

-(void) handleUnpause;
-(void) handleEndLevel;

@end
