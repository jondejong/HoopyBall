//
//  LoseLevelLayer.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LoseLevelLayer : CCLayer {

}

+(LoseLevelLayer *) layer;
-(void) handleEndLevel;

@end
