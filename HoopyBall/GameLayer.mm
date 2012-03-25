//
//  HelloWorldLayer.mm
//  Box2dHW
//
//  Created by Jonathan DeJong on 2/20/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

// Import the interfaces
#import "GameLayer.h"
#import "Constants.h"

#import "AppDelegate.h"
#import "HBUserData.h"
#import "HBContactListener.h"

#import "PhysicsSprite.h"
#import "GameManager.h"
#import "GamePlayRootNode.h"
#import "GB2ShapeCache.h"
#import "DeletableBody.h"

enum {
	kTagParentNode = 1,
    kBlockParentNode = 2,
    kBallSprite = 3,
    kEndSprite = 4,
    kBadGuySpriteTag = 5
};


bool ballCreated = false;

@implementation GameLayer {
    @private
    CGPoint startLocation;
    CCTexture2D *blockTexture_;
	CCTexture2D *spriteTexture_;	// weak ref
    CCTexture2D *starTexture_;
    CCTexture2D *badGuyTexture;
    b2Body* ballBody;
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    HBContactListener* contactListener;

    CCArray* bodiesToDelete;
    float xOffset;
    float yOffset;
}

-(id) init
{
	if( (self=[super init])) {
         bodiesToDelete = [[CCArray alloc] initWithCapacity:50];
        xOffset = 0.0f;
        yOffset = 0.0f;
        ballCreated = false;
        [self initStartLocation];
		
		// enable events
		
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;

		//Set up sprite
#if USE_GREEN_GUY
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"hoopy-ball-shapes.plist"];
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"hb_guy.png" capacity:1];
        spriteTexture_ = [parent texture];
        [self addChild:parent z:0 tag:kTagParentNode];
#else
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"red_ball.png" capacity:1];
        spriteTexture_ = [parent texture];
        [self addChild:parent z:0 tag:kTagParentNode];
#endif
        
        CCSpriteBatchNode *badGuy = [CCSpriteBatchNode batchNodeWithFile:@"black-ball.png" capacity:25];
        badGuyTexture = [badGuy texture];
        [self addChild:badGuy z:0 tag:kBadGuySpriteTag];
        
        // Add the end point
        CCSpriteBatchNode *star = [CCSpriteBatchNode batchNodeWithFile: 
                                   [ScreenSize isRetina] ? @"star-hd.png" : @"star.png"
                                                              capacity:1 ];
        
        starTexture_ = [star texture];
        [self addChild:star z:0 tag:kEndSprite];
        // init physics
		[self initPhysics];
        
		[self scheduleUpdate];
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
    starBodyDef.position.Set([[GameManager sharedInstance] getCurrentLevelEndPoint].x/PTM_RATIO, 
                          [[GameManager sharedInstance] getCurrentLevelEndPoint].y/PTM_RATIO);
    
    HBUserData* starData = [StarUserData node];
    [self addChild:starData];
    starBodyDef.userData = starData;
    
    
    b2Body* starBody = world->CreateBody(&starBodyDef);
    
    GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache]; 
    [shapeCache addFixturesToBody:starBody forShapeName:
    [ScreenSize isRetina] ? @"star-hd" : @"star"];
    
    PhysicsSprite *starSprite = [PhysicsSprite spriteWithTexture:starTexture_ ];
//    starSprite.position = [[GameManager sharedInstance] getCurrentLevelEndPoint];
    starSprite.position = ccp(1.0, 1.0);
    starSprite.anchorPoint = [shapeCache anchorPointForShape:[ScreenSize isRetina] ? @"star-hd" : @"star"];
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
//    PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:blockTexture_];
//    CCNode *parent = [self getChildByTag: kBlockParentNode];
//    [parent addChild: sprite];
//    sprite.position = ccp(p.x, p.y);
    
    b2BodyDef wallDef;
    wallDef.type = b2_staticBody;
    wallDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    HBUserData* data = [WallUserData node];
    [self addChild:data];
    wallDef.userData = data;
    
    b2Body *body = world->CreateBody(&wallDef);
    b2PolygonShape wallShape;
//    wallShape.SetAsBox(.5f, .5f);
    wallShape.SetAsBox(l/2.0f, .25f, b2Vec2(0.0f, 0.0f), a);
    b2FixtureDef wallFixture;
    wallFixture.shape = &wallShape;
    wallFixture.friction = 0.0f;
    wallFixture.density = 1.0;
    wallFixture.restitution = WALL_RESTITUTION;
    
    body->CreateFixture(&wallFixture);
        
//    [sprite setPhysicsBody:body];
}

-(void) addBall
{
//    CCLOG(@"Add ball %0.2f x %02.f",p.x,p.y);
    CCNode *parent = [self getChildByTag:kTagParentNode];
	
    PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:spriteTexture_ ];						
    [parent addChild:sprite];
	
    CGPoint lp = [[GameManager sharedInstance] getCurrentLevelStartPoint];
    sprite.position = lp; 
	
    // Define the dynamic body.
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(lp.x/PTM_RATIO, lp.y/PTM_RATIO);
    bodyDef.linearVelocity.Set(START_VELOCITY_X, START_VELOCITY_Y);
    bodyDef.bullet = true;
    
    HBUserData* data = [BallUserData node];
    [self addChild:data];
    bodyDef.userData = data;
    
    ballBody = world->CreateBody(&bodyDef);
    
	
    // Define another box shape for our dynamic body.
    b2CircleShape ballShape;
    ballShape.m_radius = .432f;
	
    // Define the dynamic body fixture.

    
#if USE_GREEN_GUY
    GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache]; 
    [shapeCache addFixturesToBody:ballBody forShapeName:@"hb_guy"];
    sprite.anchorPoint = [shapeCache anchorPointForShape:@"hb_guy"];
#else
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &ballShape;	
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 1.0f;
    ballBody->CreateFixture(&fixtureDef);	
#endif
    
    [sprite setPhysicsBody:ballBody];

}

-(void) addBadGuy {
    CCLOG(@"BOOM!");
    
    CCNode *badGuy = [self getChildByTag:kBadGuySpriteTag];
	
    PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:badGuyTexture ];						
    [badGuy addChild:sprite];
	
    CGPoint lp = [[GameManager sharedInstance] getCurrentLevelBadGuyPoint];
    sprite.position = lp; 
	
    // Define the dynamic body.
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(lp.x/PTM_RATIO, lp.y/PTM_RATIO);
    bodyDef.linearVelocity.Set([[GameManager sharedInstance] getCurrentLevelBadGuyXSpeed], [[GameManager sharedInstance] getCurrentLevelBadGuyYSpeed]);
    bodyDef.bullet = true;
    
    HBUserData* data = [BadGuyUserData node];
    [self addChild:data];
    bodyDef.userData = data;
    
    b2Body* badGuyBody = world->CreateBody(&bodyDef);
    
	
    // Define another box shape for our dynamic body.
    b2CircleShape ballShape;
    ballShape.m_radius = .432f;
    
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &ballShape;	
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 1.0f;
    badGuyBody->CreateFixture(&fixtureDef);
    
    [sprite setPhysicsBody:badGuyBody];
    
}

-(void) update: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 3;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
	[self cleanupDeletableItems];
    
    if(ballCreated) {
        b2Vec2 pos  = ballBody->GetPosition();
        
        int freq = [[GameManager sharedInstance] getCurrentLevelBadGuyFrequency];
        int rand = arc4random() % freq;

//        CCLOG(@"Freq %d -- Rand %d", freq, rand);
        
        if(rand == 1) {
            [self addBadGuy];
        }
        
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
//        if(0){
            [self addBall];
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
            
//            CGPoint center = ccp(newX/PTM_RATIO, newY/PTM_RATIO);
            
            CGPoint center = ccp(newX, newY);
            center = [[CCDirector sharedDirector] convertToGL: center];
            
            [self addNewWall:center withLength:distance andAndle:angle];
        }
        break;
    }
    [self initStartLocation];
}

-(void)updateBGPosition: (CGPoint)position {
#if USE_LARGE_WORLD
    [self doUpdateBGPosition:position];
#endif
}

-(void) doUpdateBGPosition: (CGPoint) position{
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
    } else if( (position.y > ((cameraY + windowSize.height) - yThresholdOffset)) && (cameraY + windowSize.height) <= levelSize.height){
        float yMove = yThresholdOffset - (cameraY + windowSize.height - position.y);
        yOffset += yMove;
    }
    
    [self.camera setCenterX:xOffset centerY:yOffset centerZ:0];
    [self.camera setEyeX:xOffset eyeY:yOffset eyeZ:[CCCamera getZEye]];
    
#endif
}

//-(void) markBodyForDeletion: (b2Body*)body andSprite: (CCSprite*)sprite inWorld: (b2World*) world {
-(void) markBodyForDeletion : (b2Body*) body {
    [bodiesToDelete addObject:[[DeletableBody alloc] initWithBody:body]];
}

-(void) cleanupDeletableItems {
    
    for(int i=0; i < [bodiesToDelete count]; i++) {
        DeletableBody* db = [bodiesToDelete objectAtIndex:i];
        b2Body* body = [db body];
        world->DestroyBody(body);
        //        CCSprite* sprite = [db sprite];
        //        [sprite removeFromParentAndCleanup:true];
    }
    [bodiesToDelete dealloc];
    bodiesToDelete = [[CCArray alloc] initWithCapacity:50];
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
    
    starTexture_ = nil;
    spriteTexture_ = nil;
    badGuyTexture = nil;
	
	[super dealloc];
}

@end
