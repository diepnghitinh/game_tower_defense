//
//  CInfoMap4.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoMap4.h"
#import "CGlobalSprite.h"

@implementation CInfoMap4

-(id)init
{
    if (self=[super init])
    {
        //mang ma tran
        int arr[][24] = {
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},//360
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},//312
            {0,0,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1},//312
            {0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1},//288
            {1,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,1,1,1,0,0,0},//264
            {1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,0,0},//240
            {1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,0},//216
            {1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1},//192
            {1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1},//168
            {1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1},//144
            {1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,0,0,0,0,1,1,1,1,1},//120
            {1,1,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,1,1,1,1,1,1},//96
            {1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1},//72
            {1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1},//48
            {1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1}//24
        };
        
        row = 17;
        col = 24;
        end = 215;
        start = 264;
        
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
    obj1 = [CCSprite spriteWithFile: @"4-0.png"];
    [obj1 setPosition: ccp(177, 326.5)];
    [content addChild: obj1 z: 1024];
    
    obj2 = [CCSprite spriteWithFile: @"4-1.png"];
    [obj2 setPosition: ccp(800, 465)];
    [content addChild: obj2 z: 1024];
    
    //object 3, may
    obj3 = [CCSprite spriteWithFile: @"4-2.png"];
    [obj3 setPosition: ccp(1024, 600)];
    
    id act1 = [CCMoveTo actionWithDuration:15 position: ccp(-300,600)];    
    
    act1 = [CCSequence actions:act1, [CCCallFunc actionWithTarget:self selector:@selector(ResetObject3:)], nil];
    [obj3 runAction: [CCRepeatForever actionWithAction: act1]];
    
    [content addChild: obj3 z: 1025];
    
    obj4 = [CCSprite spriteWithFile: @"4-3.png"];
    [obj4 setPosition: ccp(1200, 200)];
    
    act1 = [CCMoveTo actionWithDuration:15 position: ccp(-390,200)];    
    
    act1 = [CCSequence actions:act1, [CCCallFunc actionWithTarget:self selector:@selector(ResetObject4:)], nil];
    [obj4 runAction: [CCRepeatForever actionWithAction: act1]];
    
    [content addChild: obj4 z: 1025];
}

-(void)ResetObject3:(id)sender
{
    [obj3 setPosition: ccp(1024, 600)];
}

-(void)ResetObject4:(id)sender
{
    [obj4 setPosition: ccp(1200, 200)];
}


-(void)dealloc
{
    [CGlobalSprite RemoveSprite:obj1];
    [CGlobalSprite RemoveSprite:obj2];
    [CGlobalSprite RemoveSprite:obj3];
    [CGlobalSprite RemoveSprite:obj4];
    [super dealloc];
}

@end
