#import "HoopyBall.h"
#import "HBLevel.h"
#import "GB2ShapeCache.h"

@implementation LevelSet3

@synthesize brickTexture;
@synthesize obs1Texture;
@synthesize obs2Texture;
@synthesize obs1SmallTexture;
@synthesize obs2SmallTexture;

-(id) init {
	if(self=[super init]) {
        //Cache obstacle textures
        
        CCSpriteBatchNode *brick = [CCSpriteBatchNode batchNodeWithFile:@"level3_base_brick.png" capacity:100];
        self.brickTexture = [brick texture];
        [self addChild:brick z:0];
        
        CCSpriteBatchNode *obs1 = [CCSpriteBatchNode batchNodeWithFile:@"l3_obs1.png" capacity:10];
        self.obs1Texture = [obs1 texture];
        [self addChild:obs1 z:0];
        
        CCSpriteBatchNode *obs2 = [CCSpriteBatchNode batchNodeWithFile:@"l3_obs2.png" capacity:10];
        self.obs2Texture = [obs2 texture];
        [self addChild:obs2 z:0];
        
        CCSpriteBatchNode *obs1Small = [CCSpriteBatchNode batchNodeWithFile:@"l3_obs1_sm.png" capacity:10];
        self.obs1SmallTexture = [obs1Small texture];
        [self addChild:obs1Small z:0];
        
        CCSpriteBatchNode *obs2Small = [CCSpriteBatchNode batchNodeWithFile:@"l3_obs2_sm.png" capacity:10];
        self.obs2SmallTexture = [obs2Small texture];
        [self addChild:obs2Small z:0];
        
        // Add Obstacle Shapes to cache
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"l3_obs_shapes.plist"];
    }
    return self;
}

-(void) addObs1At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture: [self obs1Texture] ];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l3_obs1"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l3_obs1" with:&bodyDef andWith:sprite];
    
}

-(void) addObs2At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture: [self obs2Texture] ];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l3_obs2"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l3_obs2" with:&bodyDef andWith:sprite];
}

-(void) addObs1SmallAt: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture: [self obs1SmallTexture] ];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l3_obs1_sm"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l3_obs1_sm" with:&bodyDef andWith:sprite];
    
}

-(void) addObs2SmallAt: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture: [self obs2SmallTexture] ];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l3_obs2_sm"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l3_obs2_sm" with:&bodyDef andWith:sprite];
}

-(CGPoint) getEnemyStartPoint {
    return ccp(13, .5);
}

-(float) getEnemyXSpeed {
    return  0;
}
-(float) getEnemyYSpeed {return 4;}

-(int) belongsTo {
    return 3;
}

-(float) brickSideLen {
    return 2;
}

- (void)dealloc {

    [brickTexture release];
    brickTexture = nil;
    
    [obs1Texture release];
    obs1Texture = nil;
    
    [obs2Texture release];
    obs2Texture = nil;
    
    [obs1SmallTexture release];
    obs1SmallTexture = nil;
    
    [obs2SmallTexture release];
    obs2SmallTexture = nil;
    
    [super dealloc];
}

@end