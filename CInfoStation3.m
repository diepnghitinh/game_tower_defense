//
//  CInfoStation3.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoStation3.h"
#import "CInfoSkill.h"

@implementation CInfoStation3

-(id)init
{
    if (self=[super init])
    {
        damage = 300;
        radius = 120;
        cost = 6;
        attack = 120;
        level = 1;
        delay = 3;
        
        //them 1 skill vao nhan vat, ty le 30%
        CInfoSkill *skill = [[CInfoSkill alloc] init];
        skill.damage = 400;
        skill.radius = 100;
        skill.name = @"skill1";
        
        //probability
        id probability = [NSArray arrayWithObjects:[NSNumber numberWithInt: 0], [NSNumber numberWithInt: 30], nil];
        [randomSkill addObject: [NSArray arrayWithObjects:probability, skill, nil]];
        
    }
    return self;
}

@end
