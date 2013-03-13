//
//  HBPhysicsSprite.h
//  HoopyBall
//
//  Created by Jon DeJong on 3/13/13.
//
//

#import "CCSprite.h"
#import "HoopyBall.h"

@interface HBPhysicsSprite : CCSprite

@property(nonatomic, assign) b2Body *b2Body;

@end
