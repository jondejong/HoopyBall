#import "HoopyBall.h"
#import "HBLevel.h"

#include <mach/mach.h>
#include <mach/mach_time.h>
#include <unistd.h>


@implementation LevelSet1

-(id) init {
	if(self=[super init]) {
        CCSpriteBatchNode *brick = [CCSpriteBatchNode batchNodeWithFile:@"l2_base_brick.png" capacity:100];
        self.brickTexture = [brick texture];
        [self addChild:brick z:0];
    }
    return self;
}

-(int) belongsTo {
    return 1;
}

-(int) maxEnemies {
    return 1;
}

-(double) secondsBetweenEnemies {
    return 15;
}

-(CGPoint) getEnemyStartPoint {
    return ccp(3.5, .5);
}
-(float) getEnemyXSpeed {return 0;}
-(float) getEnemyYSpeed {return 3;}

-(float) brickSideLen {return 2.0;}

@end