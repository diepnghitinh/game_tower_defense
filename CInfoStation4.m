//
//  CInfoStation4.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoStation4.h"
#import "CInfoSkill.h"

@implementation CInfoStation4

-(id)init
{
    if (self=[super init])
    {
        damage = 400;
        radius = 120;
        cost = 8;
        attack = 120;
        level = 1;
        delay = 4;
        
        //them 1 skill vao nhan vat, ty le 20%
        CInfoSkill *skill = [[CInfoSkill alloc] init];
        skill.damage = 500;
        skill.radius = 100;
        skill.name = @"skill1";
        //probability
        id probability = [NSArray arrayWithObjects:[NSNumber numberWithInt: 0], [NSNumber numberWithInt: 20], nil];
        [randomSkill addObject: [NSArray arrayWithObjects:probability, skill, nil]];
        
        //them 1 skill vao nhan vat, ty le 20%
        skill = [[CInfoSkill alloc] init];
        skill.damage = 600;
        skill.radius = 100;
        skill.name = @"skill2";
        //probability
        probability = [NSArray arrayWithObjects:[NSNumber numberWithInt: 21], [NSNumber numberWithInt: 41], nil];
        [randomSkill addObject: [NSArray arrayWithObjects:probability, skill, nil]];
    }
    return self;
}

@end
