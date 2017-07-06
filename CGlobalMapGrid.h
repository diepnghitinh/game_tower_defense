//
//  CGlobalMapGrid.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CGlobalMapGrid : NSObject
{
}

//tu mot index => dong cot
+(CGPoint)IndexToOffset:(int)index;
//tu mot index => toa do
+(CGPoint)IndexToCoor:(int)index;
//tu mot toa do => o thu may tren grid
+(int)CoorToIndex:(CGPoint)point;
//dong cot => index
+(int)OffsetToIndex:(int)r col:(int)c;
//nghich dao mot toa do, dung de set z-index cho cac object tai map
+(CGPoint)InverseCoorY:(CGPoint)point;

+(int)GetRow;
+(void)SetRow:(int)val;
+(int)GetCol;
+(void)SetCol:(int)val;

@end
