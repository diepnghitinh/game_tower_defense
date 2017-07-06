//
//  CInfoEnemy4.m
//  defensequest
//
//  Created by Phuong on 5/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CInfoEnemy4.h"

@implementation CInfoEnemy4

-(id)init
{
    if (self=[super init])
    {
        health = 1000;
        level = 1;
        speed = 1;
        cost = 4;
    }
    return self;
}


@end
