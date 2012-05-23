//
//  Level2Scene.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HBLevel.h"
#import "Constants.h"
#import "HBUserData.h"
#import "GameManager.h"

@implementation Level2Scene

CGSize size;
CCTexture2D* brickTexture_;

enum {
	kBrickParentTag = 1
};

-(id) init {
    if(self = [super init]) {
        size.height = 4096 * [ScreenSize multiplier];
        size.width = 2048 * [ScreenSize multiplier];
        
        //Cache obstacle textures
        CCSpriteBatchNode *brick = [CCSpriteBatchNode batchNodeWithFile:@"brick-1.png" capacity:100];
        brickTexture_ = [brick texture];
        [self addChild:brick z:0 tag: kBrickParentTag];
    }
    return self;
}

-(CGSize) getLevelSize { return size; }
-(NSString*) getBackgroundTMX { return[ScreenSize isRetina] ? @"bg2-hd.tmx" : @"bg2.tmx";}
-(CGPoint) getStartPoint {return ccp(0.0f, 256.0f); }

-(CGPoint) getEndPoint {
    return ccp(10 * PTM_RATIO, 12 *PTM_RATIO);
}

-(CGPoint) getBadGuyStartPoint {
    return ccp(6 * PTM_RATIO, PTM_RATIO);
}

-(int) getBadGuyFrequency {return 300;}

-(float) getBadGuyXSpeed {
    return  (arc4random() % 2) == 0 ? -3.0 : 3.0;
}
-(float) getBadGuyYSpeed {return 4;}

-(void) createObstacles {
    
    float x = 6 * PTM_RATIO;
    float y = 2 * PTM_RATIO;
    
    for(int i =0; i<15; i++) {
        y = y + PTM_RATIO;
        [self addBrickAt:ccp(x, y)];
    }
}

-(void) addBrickAt: (CGPoint) p {
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    HBUserData* data = [HBUserData node];
    [self addChild:data];
    bodyDef.userData = data;
    
    b2PolygonShape brickShape;
    brickShape.SetAsBox(1.0, 0.5);
    b2FixtureDef fixture;
    fixture.shape = &brickShape;
    fixture.friction = OBJECT_FRICTION;
    fixture.density = 1.0;
    fixture.restitution = 1.0;
    
    CCSprite *sprite = [CCSprite spriteWithTexture:brickTexture_ ];	
    sprite.position = p;
    
    [[GameManager sharedInstance] addObstacle:&fixture with:&bodyDef andWith: sprite];
    
//    [sprite setPhysicsBody:brickBody];
}

- (void)dealloc
{
    brickTexture_ = nil;
    [super dealloc];
}
@end
