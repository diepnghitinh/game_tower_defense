//
//  CInfoEnemy2.m
//  defensequest
//
//  Created by Phuong on 5/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CInfoEnemy2.h"

@implementation CInfoEnemy2

-(id)init
{
    if (self=[super init])
    {
        health = 1000;
        level = 1;
        speed = 1;
        cost = 2;
    }
    return self;
}

@end
