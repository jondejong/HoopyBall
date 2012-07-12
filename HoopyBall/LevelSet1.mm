#import "HoopyBall.h"
#import "HBLevel.h"

#include <mach/mach.h>
#include <mach/mach_time.h>
#include <unistd.h>


@implementation LevelSet1

-(id) init {
	self=[super init];
    return self;
}

-(int) belongsTo {
    return 1;
}

- (void)dealloc{
    [super dealloc];
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

@end