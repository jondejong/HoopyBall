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
#import "WallContactListener.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "WallCollisionHandler.h"

#import "PhysicsSprite.h"
#import "GameScene.h"
#import "GamePlayRootNode.h"
#import "GB2ShapeCache.h"

enum {
	kTagParentNode = 1,
    kBlockParentNode = 2,
    kBallSprite = 3
};


bool ballCreated = false;

@implementation GameLayer {
    CGPoint startLocation;
    CCTexture2D *blockTexture_;
	CCTexture2D *spriteTexture_;	// weak ref
    b2Body* ballBody;
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    WallContactListener* contactListener;
}

-(id) init
{
	if( (self=[super init])) {
        ballCreated = false;
        [self initStartLocation];
		
		// enable events
		
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
		
		// init physics
		[self initPhysics];
		
		//Set up sprite
		
        
#if USE_GREEN_GUY
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"hb_guy.png" capacity:1];
        spriteTexture_ = [parent texture];
        [self addChild:parent z:0 tag:kTagParentNode];
#else
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"red_ball_sm.png" capacity:1];
        spriteTexture_ = [parent texture];
        [self addChild:parent z:0 tag:kTagParentNode];
#endif
        
        
        CCSpriteBatchNode *blockParent = [CCSpriteBatchNode batchNodeWithFile:@"block.png" capacity:50];
        blockTexture_ = [blockParent texture];
		
        [self addChild:blockParent z:0 tag:kBlockParentNode];
		
		[self scheduleUpdate];
	}
	return self;
}


-(void) initPhysics
{
	
//	CGSize s = [[CCDirector sharedDirector] winSize];
//    height = s.height;
//    width = s.width; 
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
    
    contactListener = new WallContactListener();
    world->SetContactListener(contactListener);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
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
    
    CGSize size = [[GameScene sharedInstance] getCurrentLevelSize];
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

-(void) handleEndGame {
    ballCreated = false;
}

-(void) addNewWall:(CGPoint)p withLength: (float) l andAndle: (float) a{
//    PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:blockTexture_];
//    CCNode *parent = [self getChildByTag: kBlockParentNode];
//    [parent addChild: sprite];
//    sprite.position = ccp(p.x, p.y);
    
    b2BodyDef wallDef;
    wallDef.type = b2_staticBody;
    wallDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    b2Body *body = world->CreateBody(&wallDef);
    b2PolygonShape wallShape;
//    wallShape.SetAsBox(.5f, .5f);
    wallShape.SetAsBox(l/2.0f, .25f, b2Vec2(0.0f, 0.0f), a);
    b2FixtureDef wallFixture;
    wallFixture.shape = &wallShape;
    wallFixture.friction = 0.0f;
    wallFixture.density = 1.0;
    wallFixture.restitution = WALL_RESTITUTION;
    
//    WallCollisionHandler* handler = [[WallCollisionHandler alloc] initWithWorld:world andBody:body andSprite: sprite];
    WallCollisionHandler* handler = [[WallCollisionHandler alloc] initWithWorld:world andBody:body];
    [self addChild:handler];
    wallFixture.userData = handler;
    
    body->CreateFixture(&wallFixture);
        
//    [sprite setPhysicsBody:body];
}

-(void) addNewSpriteAtPosition:(CGPoint)p
{
//    CCLOG(@"Add ball %0.2f x %02.f",p.x,p.y);
    CCNode *parent = [self getChildByTag:kTagParentNode];
	
    PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:spriteTexture_ ];						
    [parent addChild:sprite];
	
    sprite.position = ccp(p.x, p.y);
	
    // Define the dynamic body.
    //Set up a 1m squared box in the physics world
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.gravityScale = 0.0f;
    bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    bodyDef.linearVelocity.Set(START_VELOCITY_X, START_VELOCITY_Y);
    bodyDef.bullet = true;
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
	[[GameScene sharedInstance] cleanupDeletableItems];
    
    if(ballCreated) {
//        PhysicsSprite* s = (PhysicsSprite*)[self getChildByTag:kBallSprite];
//        CGPoint p = [s getPixelPosition];
        
        b2Vec2 pos  = ballBody->GetPosition();
        

//        CCLOG(@"POSITION: %f, %f", x, y);
        [[GameScene sharedInstance] updateBGPosition: ccp(pos.x * PTM_RATIO, pos.y * PTM_RATIO )];
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CCLOG(@"BOOM 1");
    for(UITouch *touch in touches) {
        startLocation = [touch locationInView: [touch view]];
        break;
    }
    
}


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch *touch in touches) {
        if(!ballCreated) {
//        if(0){
            [self addNewSpriteAtPosition: ccp(50, 100)];
            ballCreated = true;
        } else if(startLocation.x >= 0 && startLocation.y >= 0) {
            CGPoint endLocation = [touch locationInView: [touch view]];
            
//            b2Vec2 swipeVector = b2Vec2((endLocation.x - startLocation.x), (endLocation.y - startLocation.y)); 
            b2Vec2 swipeVector = b2Vec2((startLocation.x - endLocation.x), (startLocation.y - endLocation.y)); 
            float angle = (-1) * [self vec2rad: swipeVector];
            float distance = sqrtf( (swipeVector.x * swipeVector.x) + (swipeVector.y * swipeVector.y));
            distance = distance/PTM_RATIO;
            
            float xOffset = [[GameScene sharedInstance] getXOffset];
            float yOffset = [[GameScene sharedInstance] getYOffset];
            
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
	
	[super dealloc];
}

@end
