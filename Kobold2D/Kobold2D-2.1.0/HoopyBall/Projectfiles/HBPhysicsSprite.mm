//
//  HBPhysicsSprite.m
//  HoopyBall
//
//  Created by Jon DeJong on 3/13/13.
//
//

#import "HBPhysicsSprite.h"
#import "HoopyBall.h"

@implementation HBPhysicsSprite
@synthesize b2Body = _b2Body;

//-(CGPoint) getPixelPosition {
//    
//    
//    return ccp(5,5);
//}

-(BOOL) dirty
{
	return YES;
}

-(CGAffineTransform) nodeToParentTransform
{
	b2Vec2 pos  = _b2Body->GetPosition();
	
	float x = pos.x * PTM_RATIO;
	float y = pos.y * PTM_RATIO;
	
	if ( _ignoreAnchorPointForPosition ) {
		x += _anchorPointInPoints.x;
		y += _anchorPointInPoints.y;
	}
	
	// Make matrix
	float radians = _b2Body->GetAngle();
	float c = cosf(radians);
	float s = sinf(radians);
	
	// Although scale is not used by physics engines, it is calculated just in case
	// the sprite is animated (scaled up/down) using actions.
	// For more info see: http://www.cocos2d-iphone.org/forum/topic/68990
	if( ! CGPointEqualToPoint(_anchorPointInPoints, CGPointZero) ){
		x += c*-_anchorPointInPoints.x * _scaleX + -s*-_anchorPointInPoints.y * _scaleY;
		y += s*-_anchorPointInPoints.x * _scaleX + c*-_anchorPointInPoints.y * _scaleY;
	}
    
	// Rot, Translate Matrix
	_transform = CGAffineTransformMake( c * _scaleX,	s * _scaleX,
									   -s * _scaleY,	c * _scaleY,
									   x,	y );
	
	return _transform;
}

@end
