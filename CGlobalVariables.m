//
//  CGlobalVariables.m
//  defensequest
//
//  Created by dntmaster on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalVariables.h"

static NSString *debugStr = nil;
static id mapPlay = nil;

@implementation CGlobalVariables

+(void) initialize
{
    if (!debugStr)
        debugStr = @"debug string";
}

/* map play */
+(id)GetMapPlay
{
    return [mapPlay retain];
}

+(void)SetMapPlay:(id)_mapPlay
{
    mapPlay = _mapPlay;
}

/* debug string */
+(NSString *)debugStr
{
    return debugStr;
}

+(NSString *)setdebugStr:(NSString *)value
{
    return debugStr = [value copy];
}

@end
