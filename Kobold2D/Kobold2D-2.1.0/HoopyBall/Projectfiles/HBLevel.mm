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
    double _startTime;
    double _lastEnemyAddedTime;
    int _enemiesAdded;
    int _coinCount;
}

@synthesize brickTexture;

- (id)init
{
    self = [super init];
    if (self) {
        _enemiesAdded = 0;
        _coinCount = 0;
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

-(CGPoint) getEnemyStartPoint {
    return ccp(-1000, -1000);
}

-(float) getEnemyXSpeed {return 0;}
-(float) getEnemyYSpeed {return 0;}

-(void) createObstacles{}
-(void) createTargets{}

-(void) addCoinAt: (CGPoint) p {
    _coinCount++;
    [[GameManager sharedInstance] addCoinAt:p];
}

-(bool) addEnemy {
    // The default add enemy method will add an enemy at the level
    // prescribed interval up to the level prescribed maximum, defualting
    // to the default values for both.
    bool addVal = false;
    if([self enemiesAdded] < [self maxEnemies]) {
        
        double last = [self lastEnemyAddedTime];
        double now = CACurrentMediaTime();
        
        if((now - last) >= ((0 == [self enemiesAdded]) ? [self secondsBeforeFirstEnemy] : [self secondsBetweenEnemies]) ) {
            CCLOG(@"Adding enemy after %f seconds.", (now - last));
            addVal = true;
            _enemiesAdded++;
            _lastEnemyAddedTime = now;
        }
    }
    return addVal;
}

-(double) secondsBetweenEnemies {
    return HB_LEVEL_DEFAULT_SECONDS_BETWEEN_ENEMIES;
}

-(int) maxEnemies {
    return HB_LEVEL_DEFUALT_MAX_ENEMIES;
}

-(int) enemiesAdded {
    return _enemiesAdded;
}

-(void) addBrickAt: (CGPoint) p {
    p = ccp((p.x * [self brickSideLen]) + 1, (p.y * [self brickSideLen] )+ 1);
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(p.x, p.y);
    
    HBUserData* data = [HBUserData node];
    [self addChild:data];
    bodyDef.userData = (__bridge void*)data;
    
    b2PolygonShape brickShape;
    brickShape.SetAsBox(1.0, 1.0);
    b2FixtureDef fixture;
    fixture.shape = &brickShape;
    fixture.friction = OBJECT_FRICTION;
    fixture.density = 1.0;
    fixture.restitution = 1.0;
    
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"basebrick.png"];	
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    
    CCNode* batchNode = [self getChildByTag:kObsTag];
    
    b2Body* body = [[GameManager sharedInstance] createBody:&bodyDef];
    body->CreateFixture(&fixture);
    
//    [[GameManager sharedInstance] addObstacle:&fixture with:&bodyDef andWith: sprite];
    [batchNode addChild:sprite z:OBSTACLE_Z];
    
}

-(int) belongsTo {
    return 0;
}

-(void) start {
    _startTime = CACurrentMediaTime(); 
    _lastEnemyAddedTime = _startTime;
}

-(double) startTime {
    return _startTime;
}

-(float) brickSideLen {
    return 0.0;
}

-(double) lastEnemyAddedTime {
    return _lastEnemyAddedTime;
}

-(double) secondsBeforeFirstEnemy {
    return [self secondsBetweenEnemies];
}

-(int) coinCount {
    return _coinCount;
}

@end
