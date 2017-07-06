//
//  CGlobalCamera2D.h
//  defensequest
//
//  Created by dntmaster on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 Class xu ly camera map 2d
 cach su dung:
 
 camera2d = [[CGlobalCamera2D alloc] initWithSpriteAndLayer: <sprite background> : <ten layer>];
 
 //khong cho phep su dung scroll
 camera2d.EventIsScroll = NO;

 [camera2d.content addChild:sprite2 z:1 tag:1];
 
 //them camera vao layer
 [self addChild: camera2d.view];
 
 //xet zoom cho camera
 [self SetZoom: <tham so>]
 //xet viewport cho camera
 [self SetView: <tham so>]
 
 su dung cho su kien touchmoved tai layer
 [camera2d EventHandle:touches withEvent:event];
 
 */

#import "cocos2d.h"
#import "CGlobalCamera2DEffect.h"
#import "CInfoMap.h"

//trang thai cam ung cua camera truoc do
enum statusTouch {
    tnormal = 1,
    scroll = 2,
    zoom = 3,
    };

@interface CGlobalCamera2D : NSObject
{
    CCParallaxNode *root;
    CCLayer * _layer;
    CCLayer * _sprite3D;
    CCSprite * _spriteLayer;
    CCSprite * _spriteAirLayer;
    CGSize _winSize;
    CGRect _bounds; //tu sprite background => hinh chu nhat
	CGPoint _camPos; // toa do hien tai cua viewport
	CGPoint _origin; //toa do tam cua phone
    CGPoint _indentifyPos; //toa do hien tai cua sprite co trong map
    CGFloat _zoom;
    CGFloat _tmpZoom;
    //max zoom va min zoom
    CGFloat _maxZoom;
    CGFloat _minZoom;
    CCSprite * _sprite; //background sprite
    //cac config option xu ly event
    BOOL _eventIsScroll, _eventIsZoom, _eventZoomIsAnimation;
    //trang thai cua camera
    enum statusTouch _beforeStatus;
    CGSize size;
    CInfoMap *mapinfo;
}

@property (retain) CCParallaxNode * view;
@property (retain) CCSprite *content;
@property (retain) CCSprite *layer;
@property (retain) CCSprite *airlayer;
@property BOOL EventIsScroll, EventIsZoom, EventZoomIsAnimation;
@property CGFloat MaxZoom, MinZoom;
@property (readonly) CGPoint campos;
@property (readonly) CGPoint indentifypos;
@property (readwrite) CGSize size;

//init bootstrap
-(id)initWithSpriteAndLayer:(CInfoMap *) mapinfo_ : (CCLayer *)layer;

//cac xu ly cau hinh
//camera: val 0.1 -> 1
- (void)SetZoom:(float) val;
- (void)SetZoomWithDynamicType:(id) val;
- (void)FixZoom:(float *)val;
//toa do tu truc Oxy duong
- (void)SetView:(CGPoint) point;

//event
//xu ly su kien chung
- (void)EventHandleTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event;
- (void)EventHandleTouchMoved:(UITouch*)touch withEvent:(UIEvent *)event;
- (void)EventHandleTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event;

//xu ly su kien scroll
- (void)handleCameraPan:(UITouch*)touch;
//xu ly su kien zoom
- (void)handlePinchZoom:(UITouch*)touch withEvent:(UIEvent *)event;
//xu ly zoom in , zoom out
- (void)clampPositionOrZoom;
//zoom dang animation effect
- (void)ZoomAnimation:(float)val;

@end