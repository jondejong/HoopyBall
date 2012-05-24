//
//  Constants.h
//  HoopyBall
//
//  Created by Jonathan DeJong on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ScreenSize.h"

#ifndef HoopyBall_Constants_h
#define HoopyBall_Constants_h

#define DEBUG_DRAW_OUTLINE 0

#define PTM_RATIO [ScreenSize ptmRatio]

#define START_VELOCITY_X 4.0f
#define START_VELOCITY_Y 0.0f

#define WALL_RESTITUTION 1.07f

#define SHOW_FRAMERATE 0

#define CAMERA_SCROLL_SCREEN_OFFSET .25f
#define OBJECT_FRICTION 0.5f

// Usefull to turn this off when working out issues
#define DRAW_ENEMIES 1

// Usefull to turn this on when trying to place the bad guy in a new level
#define START_WITH_BAD_GUY 0

// Layering
#define WALL_Z -4
#define OBSTACLE_Z -2
#define BALL_Z -2
#define BACKGROUNG_Z -10

#endif
