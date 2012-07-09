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

@end