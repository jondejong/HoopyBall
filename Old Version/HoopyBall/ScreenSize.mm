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
    CGSize size;
    size.width = screenRect.size.width * [self multiplier];
    size.height = screenRect.size.height * [self multiplier];
    return size;
}

+(CGFloat) ptmRatio {
    return 64.0;
}

+(int) multiplier {
    return  [self isRetina]? 2 : 1;
}

+(bool) isRetina {
    return [UIScreen mainScreen].scale > 1;
}



@end
