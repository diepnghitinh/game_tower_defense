//
//  CInfoMap.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoMap.h"
#import "CGlobalSprite.h"

@implementation CInfoMap

@synthesize bg, maparray, cost, health, wave=currentWave, name, enemys, itemUnlock, row, col, end , start;

-(id)init
{
    if (self=[super init])
    {
        health = 10;
        currentWave = 0;
    }
    return self;
}

-(void)Core3d:(CCNode*)content{}

-(void)dealloc
{
    NSLog(@"root mapinfo remove");
    [CGlobalSprite RemoveSprite:bg];
    [super dealloc];
}
    
@end
