//
//  CInfoMap1.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoMap1.h"
#import "CGlobalSprite.h"

@implementation CInfoMap1

-(id)init
{
    if (self=[super init])
    {
        //mang ma tran
        int arr[][24] = {
            {1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1}, //432
            {1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1}, //408
            {0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1}, //384
            {0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0}, //360
            {0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,1,1,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0}, //312
            {0,0,1,1,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0}, //264
            {0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //216
            {1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //168
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //120
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //96
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //72
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //48
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, //24
        };
        
        row = 17;
        col = 24;
        end = 73;
        start = 421;
        
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
    obj1 = [CCSprite spriteWithFile: @"1-0.png"];
    [obj1 setPosition: ccp(316.5, 594)];
    [content addChild: obj1 z: 319];

    obj2 = [CCSprite spriteWithFile: @"1-1.png"];
    [obj2 setPosition: ccp(512, 117)];
    [content addChild: obj2 z: 705];
}

-(void)dealloc
{
    [CGlobalSprite RemoveSprite:obj1];
    [CGlobalSprite RemoveSprite:obj2];
    [super dealloc];
}

@end
