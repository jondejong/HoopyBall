//
//  GoodGuy.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface GoodGuy : CCSprite {
    
}

-(id) initInWord:(b2World*)world;

@end
