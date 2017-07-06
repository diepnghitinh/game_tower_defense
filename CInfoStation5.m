//
//  CInfoStation5.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoStation5.h"
#import "CInfoSkill.h"

@implementation CInfoStation5

-(id)init
{
    if (self=[super init])
    {
        damage = 500;
        radius = 100;
        cost = 10;
        attack = 100;
        level = 1;
        delay = 15;
        
        //them 1 skill vao nhan vat, ty le 30%
        CInfoSkill *skill = [[CInfoSkill alloc] init];
        skill.damage = 700;
        skill.radius = 100;
        skill.name = @"skill1";
        skill.slow = 10;
        
        //probability
        id probability = [NSArray arrayWithObjects:[NSNumber numberWithInt: 0], [NSNumber numberWithInt: 30], nil];
        [randomSkill addObject: [NSArray arrayWithObjects:probability, skill, nil]];
        
    }
    return self;
}

@end
