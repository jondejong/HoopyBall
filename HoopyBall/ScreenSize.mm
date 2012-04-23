//
//  ScreenSize.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScreenSize.h"

@implementation ScreenSize

+(CGSize) screenSize {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size;
}

+(CGFloat) ptmRatio {
    return 64.0 * [self multiplier];
}

+(int) multiplier {
    return  [self isRetina]? 2 : 1;
}

+(bool) isRetina {
    return[self screenSize].width > 1100;
}



@end
