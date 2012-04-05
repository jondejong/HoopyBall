//
//  ControlLayer.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ControlLayer : CCLayer {
    
}

-(void) handlePause;
-(void) handleUnpause;
-(void) deactivate;

@end
