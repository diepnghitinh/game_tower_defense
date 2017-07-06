//
//  CInfoSkill1.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoSkill2.h"

@implementation CInfoSkill2

-(id)init
{
    if (self=[super init])
    {
        damage = 1500;
        radius = 100;
        cost = 15;
        slow = 5;
        delay = 5;
    }
    return self;
}

@end
