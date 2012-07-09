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
#include <mach/mach.h>
#include <mach/mach_time.h>
#include <unistd.h>

#ifndef HB_LEVEL_H
#define HB_LEVEL_H

@interface HBLevel : CCScene {
    
}

-(CGSize) getLevelSize;
-(NSString*) getBackgroundTMX;
-(NSString*) getObsTMX;
-(CGPoint) getStartPoint;
-(CGPoint) getEndPoint;
-(CGPoint) getBadGuyStartPoint;
-(float) getBadGuyXSpeed;
-(float) getBadGuyYSpeed;
-(int) getBadGuyFrequency;
-(bool) addBadGuy;
-(void) createObstacles;
-(void) createTargets;
-(void) addCoinAt: (CGPoint) p;
-(int) belongsTo;
-(void) start;
-(uint64_t) startTime;

@end 

@interface LevelSet1 : HBLevel @end
@interface LevelSet2 : HBLevel 
    @property(nonatomic, retain) CCTexture2D* brickTexture;
    @property(nonatomic, retain) CCTexture2D* obs1Texture;
    @property(nonatomic, retain) CCTexture2D* obs2Texture;
    -(float) brickSideLen;
    -(void) addObs1At: (CGPoint) p;
    -(void) addObs2At: (CGPoint) p;
    -(void) addBrickAt: (CGPoint) p;
@end
@interface LevelSet3 : HBLevel @end

@interface Level01Scene : LevelSet1 {} @end
@interface Level02Scene : LevelSet1 {} @end
@interface Level03Scene : LevelSet1 {} @end
@interface Level04Scene : LevelSet1 {} @end
@interface Level05Scene : LevelSet1 {} @end

@interface Level06Scene : LevelSet2 @end
@interface Level07Scene : LevelSet2 @end
@interface Level08Scene : LevelSet2 @end

@interface Level09Scene : LevelSet2 @end
@interface Level10Scene : LevelSet2 @end

@interface Level11Scene : LevelSet3 @end
@interface Level12Scene : LevelSet2 @end
@interface Level13Scene : LevelSet2 @end
@interface Level14Scene : LevelSet2 @end
@interface Level15Scene : LevelSet2 @end

#endif






