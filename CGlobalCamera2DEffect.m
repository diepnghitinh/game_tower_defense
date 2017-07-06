//
//  CGlobalCamera2DEffect.m
//  defensequest
//
//  Created by dntmaster on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalCamera2DEffect.h"
#import "CGlobalCamera2D.h"

@implementation CGlobalCamera2DEffect

+(id) actionWithDuration: (ccTime)duration from:(float) s to:(float)e target:(id)target method:(SEL)func
{
	return [[[self alloc] initWithDuration: duration from: s to:e target:(id)target method:func] autorelease];
}

-(id) initWithDuration: (ccTime) t from:(float) s to:(float)e target:(id)target method:(SEL)func
{
	if( (self=[super initWithDuration: t]) ) {
        _startZoom = s;
        _endZoom = e;
        //class
        _target = (CGlobalCamera2D*)target;
        //method
        _exec = func;
	}
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration:[self duration] from:(float) _startZoom to:(float)_endZoom target:_target method:_exec];
	return copy;
}

-(void) startWithTarget:(CCNode *)aTarget
{
	[super startWithTarget:aTarget];
    _delta =_startZoom;
    //NSLog(@"begin: %f", _delta);
}

-(void) update: (ccTime) t
{
    //ap dung cong thuc van toc = s/t de tinh toan thoi gian hien tai thi di dc o thu may
    float s, v;
    s = fabsf(_startZoom - _endZoom);
    v = s/[self duration];
    
    if (_startZoom > _endZoom)
        _delta = _startZoom - (v*t);
    else
        _delta = _startZoom + (v*t);
    
    //fix lai kich co khi zoom
    [_target FixZoom:&_delta];
    //NSLog(@"update: %f - time: %f", [[NSNumber numberWithFloat:_delta] floatValue], t);

    [_target performSelector:_exec withObject: [NSNumber numberWithFloat:_delta]];
}
@end

