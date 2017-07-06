//
//  CInfoEnemy5.m
//  defensequest
//
//  Created by Phuong on 5/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CInfoEnemy5.h"

@implementation CInfoEnemy5

-(id)init
{
    if (self=[super init])
    {
        health = 1000;
        level = 1;
        speed = 1;
        cost = 5;
    }
    return self;
}


@end
