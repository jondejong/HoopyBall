//
//  GameLayer.mm
//  Created by Jonathan DeJong on 2/20/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

// Import the interfaces
#import "HoopyBall.h"

#import "ScreenSize.h"
#import "AppDelegate.h"
#import "HBUserData.h"
#import "HBContactListener.h"
#import "GLES-Render.h"
#import "PhysicsSprite.h"
#import "GB2ShapeCache.h"

enum {
	kTagParentNode = 1,
    kBlockParentNode = 2,
    kBallSprite = 3,
    kEndSprite = 4,
    kEnemySpriteTag = 5,
    kBrickTexture = 6,
    kWallTexture = 7,
    kCoinTexture = 8
};


bool ballCreated = false;

@implementation GameLayer {

@private
    CGPoint startLocation;
    
    b2Body* ballBody;
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    HBContactListener* contactListener;

    
    float xOffset;
    float yOffset;
}

@synthesize bodiesToDelete;
@synthesize blockTexture;
@synthesize spriteTexture;
@synthesize starTexture;
@synthesize enemyTexture;
@synthesize wallTexture;
@synthesize coinTexture;

-(id) init
{
	if( (self=[super init])) {
        self.bodiesToDelete = [NSMutableArray array];
        xOffset = 0.0f;
        yOffset = 0.0f;
        ballCreated = false;
        [self initStartLocation];
		
		// enable events
		
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;

		//Set up sprite

		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"red_ball.png" capacity:1];
        self.spriteTexture = [parent texture];
        [self addChild:parent z:0 tag:kTagParentNode];
        
        CCSpriteBatchNode *enemey = [CCSpriteBatchNode batchNodeWithFile:@"black-ball.png" capacity:25];
        self.enemyTexture = [enemey texture];
        [self addChild:enemey z:0 tag:kEnemySpriteTag];
        
        // Add the end point
        CCSpriteBatchNode *star = [CCSpriteBatchNode batchNodeWithFile: 
                                   [ScreenSize isRetina] ? @"star-hd.png" : @"star.png"
                                                              capacity:1 ];
        
        CCSpriteBatchNode *wall = [CCSpriteBatchNode batchNodeWithFile:@"wall.png" capacity: 200];
        self.wallTexture = [wall texture];
        [self addChild:wall z:WALL_Z tag:kWallTexture];
        
        self.starTexture = [star texture];
        [self addChild:star z:BALL_Z tag:kEndSprite];
        
        // init physics
		[self initPhysics];
        
        [self addBall];
        
#if START_WITH_BAD_GUY
        [self addEnemy];
#endif
        
	}
	return self;
}


-(void) initPhysics
{
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
    
    contactListener = new HBContactListener();
    world->SetContactListener(contactListener);
	
	uint32 flags = 0;
#if DEBUG_DRAW_OUTLINE 
	flags += b2Draw::e_shapeBit;
#endif
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);		
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;		
	
	// bottom
    
    CGSize size = [[GameManager sharedInstance] getCurrentLevelSize];
	float height = size.height;
    float width = size.width;
    
	groundBox.Set(b2Vec2(0,0), b2Vec2(width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,height/PTM_RATIO), b2Vec2(width/PTM_RATIO,height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(width/PTM_RATIO,height/PTM_RATIO), b2Vec2(width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
    
    [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"star.plist"];
    
    b2BodyDef starBodyDef;
    starBodyDef.type = b2_staticBody;
    starBodyDef.position.Set([[GameManager sharedInstance] getCurrentLevelEndPoint].x, 
                          [[GameManager sharedInstance] getCurrentLevelEndPoint].y);
    
    HBUserData* starData = [StarUserData node];
    [self addChild:starData];
    starBodyDef.userData = starData;
    
    b2Body* starBody = world->CreateBody(&starBodyDef);
    
    GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache]; 
    [shapeCache addFixturesToBody:starBody forShapeName: @"star"];
    
    PhysicsSprite *starSprite = [PhysicsSprite spriteWithTexture:starTexture];
    starSprite.anchorPoint = [shapeCache anchorPointForShape:@"star"];
    [starSprite setPhysicsBody:starBody];
    CCNode *parent = [self getChildByTag:kEndSprite];
    [parent addChild:starSprite];
    
}

-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();	
	
	kmGLPopMatrix();
}

-(void) addNewWall:(CGPoint)p withLength: (float) l andAndle: (float) a{

    // Wall length needs to be redefined to align with the sprite.
    // Round it up to the neares multiple of 1/2 the PTM Ratio
    int sCount = 0;
    float fSCount = l / .5f;
    sCount = (int) fSCount;
    float rm = fSCount - sCount;
    if(rm >= .5) {
        sCount = sCount++;
    } 
    if(sCount % 2 != 1) {
        sCount--;
    }
       
    l = .5 * sCount;  
    
    CCLOG(@"New l: %f with sCount: %d", l, sCount);
    
    //Create the sprites, and put them in the right places:
//    NSArray* sprites = [NSArray array]
    NSMutableArray *sprites = [NSMutableArray array];
    float startX = p.x;
    float startY = p.y;
    
    
// Basic trig to find the new position:    
//    x2 = x1 + d*cos A
//    y2 = y1 + d*sin A
    
    int spritesPerSide = (sCount - 1) / 2;
    
    startX = startX + (spritesPerSide * .5 * PTM_RATIO) * cos(a);
    startY = startY + (spritesPerSide * .5 * PTM_RATIO) * sin(a);

    CGPoint spritePoint = ccp(startX, startY);

    for(int i=0; i<sCount; i++) {
        CCSprite* sprite = [CCSprite spriteWithTexture:wallTexture];
        sprite.position = ccp(spritePoint.x, spritePoint.y);
        sprite.rotation = -1 * CC_RADIANS_TO_DEGREES(a);
        [self addChild:sprite z:WALL_Z];
        [sprites addObject:sprite];
        
        startX = startX - (.5 * PTM_RATIO) * cos(a);
        startY = startY - (.5 * PTM_RATIO) * sin(a);
        spritePoint = ccp(startX, startY);  

    }
    
    b2BodyDef wallDef;
    wallDef.type = b2_staticBody;
    wallDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    WallUserData* data = [WallUserData node];
    [data setSprites:sprites];
    
    [self addChild:data];
    wallDef.userData = data;
    
    b2Body *body = world->CreateBody(&wallDef);
    b2PolygonShape wallShape;
    wallShape.SetAsBox(l/2.0f, .25f, b2Vec2(0.0f, 0.0f), a);
    b2FixtureDef wallFixture;
    wallFixture.shape = &wallShape;
    wallFixture.friction = OBJECT_FRICTION;
    wallFixture.density = 1.0;
    wallFixture.restitution = WALL_RESTITUTION;
    
    body->CreateFixture(&wallFixture);

}

-(void) addBall
{
//    CCLOG(@"Add ball %0.2f x %02.f",p.x,p.y);
    CCNode *parent = [self getChildByTag:kTagParentNode];
	
    PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:spriteTexture];						
    [parent addChild:sprite z:BALL_Z];

    CGPoint lp = [[GameManager sharedInstance] getCurrentLevelStartPoint];
    sprite.position = ccp(lp.x*PTM_RATIO, lp.y*PTM_RATIO); 
	
    // Define the dynamic body.
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(lp.x, lp.y);
    bodyDef.linearVelocity.Set(START_VELOCITY_X, START_VELOCITY_Y);
    bodyDef.bullet = true;
    
    HBUserData* data = [BallUserData node];
    [self addChild:data];
    bodyDef.userData = data;
    
    ballBody = world->CreateBody(&bodyDef);
    
    // Define another box shape for our dynamic body.
    b2CircleShape ballShape;
    ballShape.m_radius = .5f;
	
    // Define the dynamic body fixture.
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &ballShape;	
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 1.0f;
    
    ballBody->CreateFixture(&fixtureDef);	
    
    [sprite setPhysicsBody:ballBody];

}

-(void) addEnemy {
    CCNode *enemy = [self getChildByTag:kEnemySpriteTag];
	
    PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:[self enemyTexture] ];						
    [enemy addChild:sprite];
	
    CGPoint lp = [[GameManager sharedInstance] getCurrentLevelEnemyPoint];
    sprite.position = ccp(lp.x * PTM_RATIO, lp.y * PTM_RATIO); 
	
    // Define the dynamic body.
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(lp.x, lp.y);
    bodyDef.linearVelocity.Set([[GameManager sharedInstance] getCurrentLevelEnemyXSpeed], [[GameManager sharedInstance] getCurrentLevelEnemyYSpeed]);
    bodyDef.bullet = true;
    
    HBUserData* data = [EnemyUserData node];
    [self addChild:data];
    bodyDef.userData = data;
    
    b2Body* enemyBody = world->CreateBody(&bodyDef);
	
    // Define another box shape for our dynamic body.
    b2CircleShape ballShape;
    ballShape.m_radius = .5f;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &ballShape;	
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 1.0f;
    enemyBody->CreateFixture(&fixtureDef);
    
    [sprite setPhysicsBody:enemyBody];
    
}

-(void) update: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 10;
	int32 positionIterations = 6;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
	[self cleanupDeletableItems];
    
    if(ballCreated) {
        b2Vec2 pos  = ballBody->GetPosition();
        
#if DRAW_ENEMIES
        if([[GameManager sharedInstance] addEnemy]) {
            [self addEnemy];
        }
#endif
        
//        CCLOG(@"POSITION: %f, %f", x, y);
        [self updateBGPosition: ccp(pos.x * PTM_RATIO, pos.y * PTM_RATIO )];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     for(UITouch *touch in touches) {
        startLocation = [touch locationInView: [touch view]];
        break;
    }
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch *touch in touches) {
        if(!ballCreated) {
            [self scheduleUpdate];
            [[GameManager sharedInstance] handleLevelPlayStarted];
            ballCreated = true;
        } else if(startLocation.x >= 0 && startLocation.y >= 0) {
            CGPoint endLocation = [touch locationInView: [touch view]];
            
            b2Vec2 swipeVector = b2Vec2((startLocation.x - endLocation.x), (startLocation.y - endLocation.y)); 
            float angle = (-1) * [self vec2rad: swipeVector];
            float distance = sqrtf( (swipeVector.x * swipeVector.x) + (swipeVector.y * swipeVector.y));
            distance = distance/PTM_RATIO;
            
            float midPointX = (endLocation.x + startLocation.x)/2;
            float midPointY = (endLocation.y + startLocation.y)/2;
            
            float newX = midPointX + xOffset;
            float newY = midPointY - yOffset;
            
            CGPoint center = ccp(newX, newY);
            center = [[CCDirector sharedDirector] convertToGL: center];
            
            [self addNewWall:center withLength:distance andAndle:angle];
        }
        break;
    }
    [self initStartLocation];
}

-(void)updateBGPosition: (CGPoint)position {
    
#if CAMERA_FOLLOW_BALL
    xOffset = position.x - [[CCDirector sharedDirector] winSize].width / 2.0f;
    yOffset = position.y - [[CCDirector sharedDirector] winSize].height / 2.0f;
    
    [self.camera setCenterX:xOffset centerY:yOffset centerZ:0];
    [self.camera setEyeX:xOffset eyeY:yOffset eyeZ:[CCCamera getZEye]]; 
#else

    // Grab some values to work wtih
    CGSize windowSize = [[CCDirector sharedDirector] winSize];
    CGSize levelSize = [[GameManager sharedInstance] getCurrentLevelSize]; 
    
    float xThresholdOffset = windowSize.width/(1.0f/CAMERA_SCROLL_SCREEN_OFFSET);
    float yThresholdOffset = windowSize.height/(1.0f/CAMERA_SCROLL_SCREEN_OFFSET);
    
    // Find out the current edge of the viewport
    float cameraX, cameraY, cameraZ;
    
    [self.camera centerX:&cameraX centerY:&cameraY centerZ:&cameraZ];
    
    // see if we need to move the X
    if( (position.x < (cameraX + xThresholdOffset)) && cameraX > 0) {
        float xMove = cameraX + xThresholdOffset - position.x;
        xOffset -= xMove;
        
    } else if( (position.x > ((cameraX + windowSize.width) - xThresholdOffset)) && (cameraX + windowSize.width) < levelSize.width){
        float xMove = xThresholdOffset - (cameraX + windowSize.width - position.x);
        xOffset += xMove;
    }
    
    // see if we need to move the Y
    if( (position.y < (cameraY + yThresholdOffset)) && cameraY > 0) {
        float yMove = cameraY + yThresholdOffset - position.y;
        yOffset -= yMove;
    } else if( (position.y > ((cameraY + windowSize.height) - yThresholdOffset)) && (cameraY + windowSize.height) < levelSize.height){
        float yMove = yThresholdOffset - (cameraY + windowSize.height - position.y);
        yOffset += yMove;
    }
    
    [self.camera setCenterX:xOffset centerY:yOffset centerZ:0];
    [self.camera setEyeX:xOffset eyeY:yOffset eyeZ:[CCCamera getZEye]];
#endif
}

//-(void) markBodyForDeletion: (b2Body*)body andSprite: (CCSprite*)sprite inWorld: (b2World*) world {
-(void) markBodyForDeletion : (b2Body*) body {
    DeletableBody* db = [[[DeletableBody alloc] initWithBody:body]autorelease];
    [bodiesToDelete addObject:db];
}

-(void) cleanupDeletableItems {
    
    for(int i=0; i < [bodiesToDelete count]; i++) {
        DeletableBody* db = [bodiesToDelete objectAtIndex:i];
        if(![db isAlreadyDeleted]) {
            b2Body* body = [db body];
            world->DestroyBody(body);
            [db deleted];
        }
    }
    self.bodiesToDelete = [NSMutableArray array];
}

-(void)addStaticBody: (b2FixtureDef*)fixture with: (b2BodyDef*)bodyDef andWith: (CCSprite*) sprite{
    b2Body* body = world->CreateBody(bodyDef);
    body->CreateFixture(fixture);
    [self addChild:sprite z:OBSTACLE_Z];
}

-(void) addCachedStaticBody: (NSString*)fixtureShapeName with: (b2BodyDef*)bodyDef andWith: (CCSprite*) sprite {
    b2Body* body = world->CreateBody(bodyDef);
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:fixtureShapeName];
    [self addChild:sprite z:OBSTACLE_Z];
}

-(void) addCachedStaticBody: (NSString*)fixtureShapeName with: (b2BodyDef*)bodyDef {
    b2Body* body = world->CreateBody(bodyDef);
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:fixtureShapeName];
}

-(void) initStartLocation {
    startLocation.x = -1;
    startLocation.y = -1;
}

-(float) vec2rad : (b2Vec2) v{
    return atan2(v.y,v.x);
}

-(void) dealloc
{
    delete contactListener;
    contactListener = NULL;
    
	delete world;
	world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
    
    [bodiesToDelete release];
    bodiesToDelete = nil;

    [blockTexture release];
    [spriteTexture release];
    [starTexture release];
    [enemyTexture release];
    [wallTexture release];
    [coinTexture release];
    
    blockTexture = nil;
    spriteTexture = nil;
    starTexture = nil;
    enemyTexture = nil;
    wallTexture = nil;
    coinTexture = nil;
    
    
	[super dealloc];
}

@end
