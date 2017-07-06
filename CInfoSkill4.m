//
//  CInfoSkill3.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoSkill4.h"

@implementation CInfoSkill4

-(id)init
{
    if (self=[super init])
    {
        damage = 5000;
        radius = 50;
        cost = 20;
        slow = 30;
        delay = 15;
    }
    return self;
}

@end
