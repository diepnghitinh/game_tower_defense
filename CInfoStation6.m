//
//  CInfoStation6.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoStation6.h"
#import "CInfoSkill.h"

@implementation CInfoStation6

-(id)init
{
    if (self=[super init])
    {
        damage = 200;
        radius = 300;
        cost = 5;
        attack = 300;
        level = 1;
        delay = 4;
        
        //them 1 skill vao nhan vat, ty le 20%
        CInfoSkill *skill = [[CInfoSkill alloc] init];
        skill.damage = 500;
        skill.radius = 100;
        skill.name = @"skill1";
        //probability
        id probability = [NSArray arrayWithObjects:[NSNumber numberWithInt: 0], [NSNumber numberWithInt: 30], nil];
        [randomSkill addObject: [NSArray arrayWithObjects:probability, skill, nil]];        
    }
    return self;
}

@end
