//
//  CInfoSkill0.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoSkill1.h"

@implementation CInfoSkill1

-(id)init
{
    if (self=[super init])
    {
        damage = 1000;
        radius = 50;
        cost = 10;
        slow = 0;
        delay = 1;
    }
    return self;
}

@end
