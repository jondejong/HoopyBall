#import "HoopyBall.h"
#import "HBLevel.h"
#import "GB2ShapeCache.h"
#import "HBUserData.h"

@implementation LevelSet2 {
    @private
    float brickSideLen;
}

@synthesize brickTexture;
@synthesize obs1Texture;
@synthesize obs2Texture;

-(id) init {
	if(self=[super init]) {
        brickSideLen = 2.0f;
        
        //Cache obstacle textures
        
        CCSpriteBatchNode *brick = [CCSpriteBatchNode batchNodeWithFile:@"l2_base_brick.png" capacity:100];
        self.brickTexture = [brick texture];
        [self addChild:brick z:0];
        
        CCSpriteBatchNode *obs1 = [CCSpriteBatchNode batchNodeWithFile:@"l2_obs_1_base_small.png" capacity:100];
        self.obs1Texture = [obs1 texture];
        [self addChild:obs1 z:0];
        
        CCSpriteBatchNode *obs2 = [CCSpriteBatchNode batchNodeWithFile:@"l2_obs_1_base.png" capacity:100];
        self.obs2Texture = [obs2 texture];
        [self addChild:obs2 z:0];
        
        // Add Obstacle Shapes to cache
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"l2_obs_shapes.plist"];
    }
    return self;
}

-(int) belongsTo {
    return 2;
}

-(float) brickSideLen {
    return brickSideLen;
}

-(void) addObs1At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture: [self obs1Texture]];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l2_obs_1_base_small"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l2_obs_1_base_small" with:&bodyDef andWith:sprite];
}

-(void) addObs2At: (CGPoint) p {
    CCSprite * sprite = [CCSprite spriteWithTexture: [self obs2Texture]];
    sprite.position = ccp(p.x*PTM_RATIO, p.y*PTM_RATIO);
    sprite.anchorPoint = [[GB2ShapeCache sharedShapeCache] anchorPointForShape:@"l2_obs_1_base"];
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(p.x, p.y);
    [[GameManager sharedInstance] addCachedObstacle:@"l2_obs_1_base" with:&bodyDef andWith:sprite];
}



- (void) dealloc {
    [brickTexture release];
    brickTexture = nil;
    
    [obs1Texture release];
    obs1Texture = nil;
    
    [obs2Texture release];
    obs2Texture = nil;
    
    [super dealloc];
}

@end