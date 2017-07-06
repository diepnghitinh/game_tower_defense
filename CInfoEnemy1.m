//
//  CInfoEnemy1.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoEnemy1.h"

@implementation CInfoEnemy1

-(id)init
{
    if (self=[super init])
    {
        health = 1000;
        level = 1;
        speed = 1;
        cost = 1;
    }
    return self;
}

@end
