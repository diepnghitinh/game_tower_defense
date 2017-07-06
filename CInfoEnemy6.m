//
//  CInfoEnemy6.m
//  defensequest
//
//  Created by Phuong on 5/30/11.
//  Copyright (c) 2011 __MyCompanyName_hguyhg_. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CInfoEnemy6.h"

@implementation CInfoEnemy6

-(id)init
{
    if (self=[super init])
    {
        health = 1000;
        level = 1;
        speed = 0.8;
        cost = 6;
    }
    return self;
}


@end
