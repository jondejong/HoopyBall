#import "HoopyBall.h"
#import "HBLevel.h"
#import "GB2ShapeCache.h"

@implementation LevelSet3

@synthesize brickTexture;
@synthesize obs1Texture;
@synthesize obs2Texture;

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
    
    [super dealloc];
}

@end