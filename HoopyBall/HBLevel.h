//
//  HBLevel.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@protocol HBLevel <NSObject>

-(CGSize) getCurrentLevelSize;
-(NSString*) getCurrentBackgroundTMX;

@end
