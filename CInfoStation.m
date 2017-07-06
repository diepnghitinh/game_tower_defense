//
//  CInfoStation.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoStation.h"

@implementation CInfoStation

@synthesize level, attack, randomSkill;

-(id)init
{
    if (self=[super init])
    {
        randomSkill = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
