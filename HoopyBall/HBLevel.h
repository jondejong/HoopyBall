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

@interface HBLevel : CCScene {
    
}

-(CGSize) getLevelSize;
-(NSString*) getBackgroundTMX;
-(CGPoint) getStartPoint;
-(CGPoint) getEndPoint;
-(CGPoint) getBadGuyStartPoint;
-(float) getBadGuyXSpeed;
-(float) getBadGuyYSpeed;
-(int) getBadGuyFrequency;

@end 

@interface Level1Scene : HBLevel {} @end
@interface Level2Scene : HBLevel {} @end





