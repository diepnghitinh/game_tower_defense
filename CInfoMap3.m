//
//  CInfoMap3.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoMap3.h"
#import "CGlobalSprite.h"

@implementation CInfoMap3

-(id)init
{
    if (self=[super init])
    {
        //mang ma tran
        int arr[][24] = {
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            {1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,1,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //360
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //312
            {0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //264
            {0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //216
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //168
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0}, //120
            {1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //72
            {1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
        };
        
        row = 17;
        col = 24;
        end = 263;
        start = 240;
        
        maparray = [[NSMutableArray alloc] init];
        for (int i = row, e = 0; i >= 0; --i, ++e)
        {
            [maparray addObject: [[NSMutableArray alloc] init] ];
            
            for (int j = 0; j < col; ++j)
                [[maparray objectAtIndex: e] addObject: [NSNumber numberWithInt: arr[i][j]]];
        }        
        
    }
    return self;
}

-(void)Core3d:(CCNode*)content
{
    obj1 = [CCSprite spriteWithFile: @"3-0.png"];
    [obj1 setPosition: ccp(512, 107.5)];
    [content addChild: obj1 z: 768];
}

-(void)dealloc
{
    [CGlobalSprite RemoveSprite:obj1];
    [super dealloc];
}

@end
