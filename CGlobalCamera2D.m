//
//  CGlobalCamera2D.m
//  defensequest
//
//  Created by dntmaster on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalCamera2D.h"

@implementation CGlobalCamera2D

@synthesize view = root, content = _sprite, layer = 
_spriteLayer, airlayer = _spriteAirLayer;
@synthesize EventIsScroll = _eventIsScroll, EventIsZoom = _eventIsZoom, EventZoomIsAnimation = _eventZoomIsAnimation;
@synthesize MaxZoom, MinZoom;
@synthesize campos = _camPos;
@synthesize indentifypos = _indentifyPos;
@synthesize size;

-(id)init
{
    if (self = [super init])
    {
        //init default handle
        _eventIsScroll = YES;
        _eventIsZoom = YES;
        _eventZoomIsAnimation = NO;
        _maxZoom = 1;
        if (iPad)
            _maxZoom = 2;
        _minZoom = 0.4;
        //touch camera status
        _beforeStatus = tnormal;
        _winSize = _layer.contentSize;
        _origin = CGPointMake(_winSize.width/2.0, _winSize.height/2.0);
		_camPos = _origin;
        
		root = [[CCParallaxNode alloc] init];
		[root setIsRelativeAnchorPoint:YES];
        
        //tao 1 layer nam tren tat ca cac sprite camera
		_spriteLayer = [CCSprite spriteWithFile: @"space.png"];
        [_spriteLayer setContentSize:CGSizeMake(_sprite.contentSize.width, _sprite.contentSize.height)];
        
        _spriteAirLayer = [CCSprite spriteWithFile: @"space.png"];
        [_spriteAirLayer setContentSize:CGSizeMake(_sprite.contentSize.width, _sprite.contentSize.height)];
        
        //layer gia map 2.5D
        [mapinfo Core3d: _sprite];

        //tao layer chiu tac dong cua camera
        CCLayer *layer = [CCLayer node];
        [layer addChild: _sprite];
        [layer addChild: _spriteAirLayer];
        [layer addChild: _spriteLayer];
        
        CGPoint offset = ccp([_sprite contentSize].width/2.0, [_sprite contentSize].height/2.0);
		
        [root addChild:layer z:0 parallaxRatio: ccp(1.0, 1.0) positionOffset: offset];

        //[root setContentSize:CGSizeMake(365, 320)];
        
		_bounds = [_sprite textureRect];
        
		//[root setContentSize:[_sprite contentSize]];
        
        //khoi tao zoom va viewport default
        [self SetZoom: _minZoom];
        [self SetView: offset];
        
    }
    return self;
}

-(id)initWithSpriteAndLayer:(CInfoMap *) mapinfo_ : (CCLayer *)layer
{
    _sprite = mapinfo_.bg;
    _layer = layer;
    mapinfo = mapinfo_;
    return [self init];
}

//xu ly zoom theo dang hieu ung animation
- (void)ZoomAnimation:(float)val
{
    
    id effect = [CGlobalCamera2DEffect actionWithDuration:0.5 from:_zoom to:val target:self method:@selector(SetZoomWithDynamicType:)];
    //khoi tao dang animation
    id ease = [CCEaseSineOut actionWithAction: effect];

    [_layer runAction: ease];
}

- (void)SetZoomWithDynamicType:(id) val
{
    [self SetZoom: [val floatValue]];
}

//cac xu ly cau hinh camera
- (void)SetZoom:(float) val
{
    _zoom = val;
    [self FixZoom:&_zoom];
    _tmpZoom = _zoom;
    
    //NSLog(@"i : %f", val);
    
    [self clampPositionOrZoom];  // if you want to prevent it going outside some boundary.
	[_layer setScale:_zoom];
  
	CGPoint _nodePos = ccpNeg(ccpSub(_camPos, _origin));  // will have updated _camPos from zoom in.
	[root setPosition:_nodePos];
}

- (void)FixZoom:(float *)val
{
    if (*val < _minZoom)
        *val = _minZoom;
    if (*val > _maxZoom)
        *val = _maxZoom;
}

- (void)SetView:(CGPoint) point
{
    _camPos = point;
	
	[self clampPositionOrZoom];
	
    //Camera se view o trung tam
	CGPoint _nodePos = ccpNeg(ccpSub(_camPos, _origin));
	
    [root setPosition:_nodePos];
}

//xu ly su kien touch began
- (void)EventHandleTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
	
    //lay toa do sprite tai parallax
    _indentifyPos = [root convertTouchToNodeSpace:touch];
    
}

//xu ly su kien touch move
- (void)EventHandleTouchMoved:(UITouch*)touch  withEvent:(UIEvent *)event
{
    switch ([[event allTouches] count]) {
		case 1:
            if (_eventIsScroll == YES)
                [self handleCameraPan:touch];
			break;
		case 2:
            if (_eventIsZoom == YES)
                [self handlePinchZoom:touch withEvent:event];
			break;
	}
}

//xu ly su kien touch end
- (void)EventHandleTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
    //neu cho phep su dung animation va touch truoc do la zoom thi thuc hien
    if (_eventZoomIsAnimation == YES && _beforeStatus == zoom)
        [self ZoomAnimation:_tmpZoom];
    
    _beforeStatus = tnormal;
}

//xu ly cham va keo
- (void)handleCameraPan:(UITouch*)touch {
	
    _beforeStatus = scroll;
    
	//UITouch *touch = [touches anyObject];
	
	CGPoint touchLocation = [touch locationInView: [touch view]];	
	CGPoint prevLocation = [touch previousLocationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	prevLocation = [[CCDirector sharedDirector] convertToGL: prevLocation];
    
    
	// subtract
	CGPoint diff = ccpMult(ccpSub(touchLocation,prevLocation), 1.0/[_layer scale]);  // 1/scale because we need to put the distance in screen coords into game board coords.
    
	_camPos = ccpSub(_camPos, diff);
    
    
    [self SetView: _camPos];
}

//xu ly da diem zoom
- (void)handlePinchZoom:(UITouch*)touch withEvent:(UIEvent *)event {
	
    _beforeStatus = zoom;
    
	NSSet *allTouches = [event allTouches];
	
    UITouch* touch1 = [[allTouches allObjects] objectAtIndex:0];
    UITouch* touch2 = [[allTouches allObjects] objectAtIndex:1];
    
    // calculate scale value
    double prevDistance = ccpDistance([touch1 previousLocationInView:[touch1 view]], [touch2 previousLocationInView:[touch2 view]]); 
    double newDistance  = ccpDistance([touch1 locationInView:[touch1 view]], [touch2 locationInView:[touch2 view]]); 
    CGFloat diff = newDistance - prevDistance;
    
	// CAM CONTROLS

	if (_eventZoomIsAnimation == NO)
    {
        _zoom += (diff*0.002);  // 0.005 just some experimentally determined value.
        [self SetZoom:_zoom];
    } else
    {
        _tmpZoom += (diff*0.002);
        [self FixZoom:&_tmpZoom];
        //NSLog(@"from: %f - to: %f", _zoom, _tmpZoom);
    }
	
}

//xu ly zoom in
-(void)clampPositionOrZoom
{
	
	_zoom = _zoom <= _winSize.width/_bounds.size.width ? _winSize.width/_bounds.size.width : _zoom;  // prevents from zooming too far.
	
	_camPos.x = MIN(MAX(_camPos.x, _bounds.origin.x + _winSize.width/(2*_zoom)), _bounds.size.width - _winSize.width/(2*_zoom));
	_camPos.y = MIN(MAX(_camPos.y, _bounds.origin.y + _winSize.height/(2*_zoom)), _bounds.size.height - _winSize.height/(2*_zoom));
	
}

@end
