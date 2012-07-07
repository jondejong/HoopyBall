//
//  LBLevel.m
//  HoopyBall
//
//  Created by Jonathan DeJong on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HoopyBall.h"

#import "HBLevel.h"
#import "HBUserData.h"

@implementation HBLevel {

@private
    @private
    CCTexture2D* coinTexture;
    
    enum {
        kCoinParentTag = 1
    };
    
}

- (id)init
{
    self = [super init];
    if (self) {
        CCSpriteBatchNode *coin = [CCSpriteBatchNode batchNodeWithFile:@"smiley.png" capacity:100];
        coinTexture = [coin texture];
        [self addChild:coin z:0 tag: kCoinParentTag];
    }
    return self;
}

-(CGSize) getLevelSize {
    CGSize retVal;
    return retVal;
}
-(NSString*) getBackgroundTMX {
    return @"";
}

-(NSString*) getObsTMX {
    return nil;
}

-(CGPoint) getStartPoint {
    CGPoint p = ccp(0.0f, PTM_RATIO);
    return p;
}

-(CGPoint) getEndPoint {
    return ccp([ScreenSize screenSize].width, [ScreenSize screenSize].height);
}

-(CGPoint) getBadGuyStartPoint {
    return ccp(-1000, -1000);
}

-(float) getBadGuyXSpeed {return 0;}
-(float) getBadGuyYSpeed {return 0;}

-(int) getBadGuyFrequency {return 10000;}

-(void) createObstacles{}
-(void) createTargets{}

-(void) addCoinAt: (CGPoint) p {
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(p.x, p.y);
    
    CoinUserData* data = [CoinUserData node];
    [self addChild:data];
    bodyDef.userData = data;
    
    b2CircleShape coinShape;
    coinShape.m_radius = .5f;
    b2FixtureDef coinFixture;
    coinFixture.shape = &coinShape;
    coinFixture.density = 0.0f;
    coinFixture.friction = 0.0f;
    coinFixture.restitution = 0.0;
    coinFixture.isSensor = true;
    
    CCSprite *sprite = [CCSprite spriteWithTexture:coinTexture];	
    sprite.position = ccp(p.x * PTM_RATIO, p.y * PTM_RATIO);
    [data setSprite:sprite];
    
    [[GameManager sharedInstance] addObstacle:&coinFixture with:&bodyDef andWith: sprite];
}

-(bool) addBadGuy {
    int freq = [self getBadGuyFrequency];
    int rand = arc4random() % freq;
    
    return (rand == 1); 
}

- (void)dealloc
{
    coinTexture =  nil;
    [super dealloc];
}

@end
