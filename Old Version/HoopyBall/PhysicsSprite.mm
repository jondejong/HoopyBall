//
//  PhysicsSprite.mm
//  Box2dHW
//
//  Created by Jonathan DeJong on 2/20/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "PhysicsSprite.h"

#import "HoopyBall.h"
#import "ScreenSize.h"

#pragma mark - PhysicsSprite
@implementation PhysicsSprite

-(void) setPhysicsBody:(b2Body *)body
{
	body_ = body;
}

-(CGPoint) getPixelPosition {
    b2Vec2 pos  = body_->GetPosition();
    
    float x = pos.x * PTM_RATIO;
	float y = pos.y * PTM_RATIO;
	
	if ( !isRelativeAnchorPoint_ ) {
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
    
    CCLOG(@"POSITION: %f, %f", x, y);
    
    return ccp(x, y);
}

// this method will only get called if the sprite is batched.
// return YES if the physics values (angles, position ) changed
// If you return NO, then nodeToParentTransform won't be called.
-(BOOL) dirty
{
	return YES;
}


// returns the transform matrix according the Chipmunk Body values
-(CGAffineTransform) nodeToParentTransform
{	
	b2Vec2 pos  = body_->GetPosition();
	
	float x = pos.x * PTM_RATIO;
	float y = pos.y * PTM_RATIO;
	
	if ( !isRelativeAnchorPoint_ ) {
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
    
//    CCLOG(@"POSITION: %f, %f", x, y);
	
	// Make matrix
	float radians = body_->GetAngle();
	float c = cosf(radians);
	float s = sinf(radians);
	
	if( ! CGPointEqualToPoint(anchorPointInPoints_, CGPointZero) ){
		x += c*-anchorPointInPoints_.x + -s*-anchorPointInPoints_.y;
		y += s*-anchorPointInPoints_.x + c*-anchorPointInPoints_.y;
	}
	
	// Rot, Translate Matrix
	transform_ = CGAffineTransformMake( c,  s,
									   -s,	c,
									   x,	y );	
	
	return transform_;
}

-(void) dealloc
{
	//
    body_ = nil;
	[super dealloc];
}

@end
