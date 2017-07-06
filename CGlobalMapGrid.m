//
//  CGlobalMapGrid.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalMapGrid.h"
#import "CBusiMap.h"
#import "GlobalVariables.h"

static NSNumber *row = nil;
static NSNumber *col = nil;

@implementation CGlobalMapGrid

//nghich dao mot toa do theo Y
+(CGPoint)InverseCoorY:(CGPoint)point
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    //khoang cach tu tam den y thuc
    float dis = abs(busmap.camera2D.content.contentSize.height/2-point.y);
    
    //bat dau nghich dao mot y thong qua toa do tam
    if (point.y < busmap.camera2D.content.contentSize.height/2)
        return ccp(point.x,busmap.camera2D.content.contentSize.height/2 + dis);
    return ccp(point.x,busmap.camera2D.content.contentSize.height/2 - dis);
}

+(CGPoint)IndexToCoor:(int)index
{
    float r,c;
    
    r = index%[col intValue] * tileSize;
    c = index/[col intValue] * tileSize;
    //cong 1/2 tile de dich 1 sprite vao tam
    return ccp(r+tileSize/2, c+tileSize/2);
}

+(int)CoorToIndex:(CGPoint)point
{
    int c = (int)(point.x / tileSize);
    int r = (int)(point.y / tileSize);
    if (r < 1)
        return c;
    return r*[col intValue] + c;
}

//tu mot index => dong cot
+(CGPoint)IndexToOffset:(int)index
{
    int r, c;
    r = index/[col intValue];
    c = index%[col intValue];
    return ccp(r, c);
}

//tu dong cot => index
+(int)OffsetToIndex:(int)r col:(int)c
{
    if (r < 1)
        return c;
    if (r < 0 || r > [row intValue] || c < 0 || c > [col intValue])
        return -1;
    return r * [col intValue] + c;
}

+(int)GetRow
{
    return [row intValue];
}

+(void)SetRow:(int)val
{
    row = [[NSNumber numberWithInt: val] retain];
}

+(int)GetCol
{
    return [col intValue];
}

+(void)SetCol:(int)val
{
    col = [[NSNumber numberWithInt: val] retain];
}

@end
