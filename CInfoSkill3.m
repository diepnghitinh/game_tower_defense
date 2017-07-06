//
//  CInfoSkill2.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoSkill3.h"

@implementation CInfoSkill3

-(id)init
{
    if (self=[super init])
    {
        damage = 2000;
        radius = 50;
        cost = 15;
        slow = 0;
        delay = 10;
    }
    return self;
}

@end
