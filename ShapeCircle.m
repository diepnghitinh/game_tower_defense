//
//  ShapeCircle.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShapeCircle.h"

@implementation ShapeCircle

-(id) initWithColor:(ccColor4B) _color radius:(float)_radius
{
	if( (self=[super init])) {
        color = _color;
        radius = _radius;
	}
	return self;
}

-(void) RefreshColor:(ccColor4B) _color;
{
    color = _color;
    glColor4f(_color.r,_color.g,_color.b,_color.a);
}

- (void) draw
{
    glColor4f(color.r,color.g,color.b,color.a);
    CGPoint center = ccp(0.f, 0.f);
    CGFloat _radius = radius;
    CGFloat angle = 0.f;
    NSInteger segments = 100;
    BOOL drawLineToCenter = NO;
    glLineWidth(2.0f);
    ccDrawCircle(center, _radius, angle, segments, drawLineToCenter); 
}

@end
