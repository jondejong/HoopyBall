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

enum {
	kTagParentNode = 1,
    kBlockParentNode = 2
};


@interface GameLayer()
-(void) initPhysics;
-(void) addNewSpriteAtPosition:(CGPoint)p;
-(void) addNewWall:(CGPoint)p;

@end

bool ballCreated = false;

@implementation GameLayer

-(id) init
{
	if( (self=[super init])) {
		
		// enable events
		
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
		
		// init physics
		[self initPhysics];
		
		//Set up sprite
		
#if 1
		// Use batch node. Faster
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"red_ball_sm.png" capacity:10];
		spriteTexture_ = [parent texture];
        
        CCSpriteBatchNode *blockParent = [CCSpriteBatchNode batchNodeWithFile:@"block.png" capacity:50];
        blockTexture_ = [blockParent texture];
#else
		// doesn't use batch node. Slower
		spriteTexture_ = [[CCTextureCache sharedTextureCache] addImage:@"blocks.png"];
		CCNode *parent = [CCNode node];
#endif
		[self addChild:parent z:0 tag:kTagParentNode];
        [self addChild:blockParent z:0 tag:kBlockParentNode];
		
		[self scheduleUpdate];
	}
	return self;
}



-(void) initPhysics
{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
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
//	flags += b2Draw::e_shapeBit;
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
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
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

-(void) addNewWall:(CGPoint)p {
    PhysicsSprite *sprite = [PhysicsSprite spriteWithTexture:blockTexture_];
    CCNode *parent = [self getChildByTag: kBlockParentNode];
    [parent addChild: sprite];
    sprite.position = ccp(p.x, p.y);
    
    b2BodyDef wallDef;
    wallDef.type = b2_staticBody;
    wallDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
    
    b2Body *body = world->CreateBody(&wallDef);
    b2PolygonShape wallShape;
    wallShape.SetAsBox(.5f, .5f);
    b2FixtureDef wallFixture;
    wallFixture.shape = &wallShape;
    wallFixture.friction = 0.0f;
    wallFixture.density = 1.0;
    wallFixture.restitution = .8f;
    
    WallCollisionHandler* handler = [[WallCollisionHandler alloc] initWithWorld:world andBody:body andSprite: sprite];
    [self addChild:handler];
    wallFixture.userData = handler;
    
    body->CreateFixture(&wallFixture);
        
    [sprite setPhysicsBody:body];
}

-(void) addNewSpriteAtPosition:(CGPoint)p
{
    CCLOG(@"Add ball %0.2f x %02.f",p.x,p.y);
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
    bodyDef.linearVelocity.Set(8.0f, 5.0f);
    bodyDef.bullet = true;
    b2Body *body = world->CreateBody(&bodyDef);
	
    // Define another box shape for our dynamic body.
    b2CircleShape ballShape;
    ballShape.m_radius = .432f;
	
    // Define the dynamic body fixture.
    b2FixtureDef fixtureDef;
    fixtureDef.shape = &ballShape;	
    fixtureDef.density = 1.0f;
    fixtureDef.friction = 0.0f;
    fixtureDef.restitution = 1.0f;
    body->CreateFixture(&fixtureDef);
	
    [sprite setPhysicsBody:body];

}

-(void) update: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 5;
	int32 positionIterations = 3;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
	[[GameScene sharedInstance] cleanupDeletableItems];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];

		if(!ballCreated) {
            [self addNewSpriteAtPosition: location];
            ballCreated = true;
        } else {
            [self addNewWall: location];
        }
	}
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
