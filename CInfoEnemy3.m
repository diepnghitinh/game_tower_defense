//
//  CInfoEnemy3.m
//  defensequest
//
//  Created by Phuong on 5/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CInfoEnemy3.h"

@implementation CInfoEnemy3

-(id)init
{
    if (self=[super init])
    {
        health = 1000;
        level = 1;
        speed = 1;
        cost = 3;
    }
    return self;
}


@end
