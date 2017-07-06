//
//  CInfoStation2.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoStation2.h"
#import "CInfoSkill.h"

@implementation CInfoStation2

-(id)init
{
    if (self=[super init])
    {
        damage = 200;
        radius = 120;
        cost = 4;
        attack = 120;
        level = 1;
        delay = 2;
        
        //them 1 skill vao nhan vat, ty le 20%
        CInfoSkill *skill = [[CInfoSkill alloc] init];
        skill.damage = 300;
        skill.radius = 100;
        skill.name = @"skill1";
        //probability
        id probability = [NSArray arrayWithObjects:[NSNumber numberWithInt: 0], [NSNumber numberWithInt: 20], nil];
        [randomSkill addObject: [NSArray arrayWithObjects:probability, skill, nil]];
        
    }
    return self;
}

@end
