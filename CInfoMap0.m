//
//  CInfoMap0.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoMap0.h"
#import "CGlobalSprite.h"

@implementation CInfoMap0

-(id)init
{
    if (self=[super init])
    {
        //mang ma tran
        int arr[][24] = {
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            {0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            {0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1}, //360
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,1,1,1},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1}, //312
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //264
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //216
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //168
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0},
            {0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //120
            {1,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,1,1,0,1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, //72
            {0,0,0,1,0,0,0,1,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0},
        };

        row = 17;
        col = 24;
        end = 16;
        start = 361;
        
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
    obj1 = [CCSprite spriteWithFile: @"0-0.png"];
    [obj1 setPosition: ccp(175, 155)];
    [content addChild: obj1 z: 660];
    
    obj2 = [CCSprite spriteWithFile: @"0-1.png"];
    [obj2 setPosition: ccp(860, 340)];
    [content addChild: obj2 z: 532];
}

-(void)dealloc
{
    [CGlobalSprite RemoveSprite:obj1];
    [CGlobalSprite RemoveSprite:obj2];
    [super dealloc];
}

@end
