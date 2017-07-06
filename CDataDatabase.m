//
//  CDataMapInfo.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CDataDatabase.h"

@implementation CDataDatabase

-(id)init
{
    if (self=[super init])
    {
        file = [[NSBundle mainBundle] bundlePath];
        file = [file stringByAppendingPathComponent:@"database.plist"];
    }
    return self;
}

-(id)initWithFile: (NSString*)filename
{
    if (self=[super init])
    {
        file = [[NSBundle mainBundle] bundlePath];
        file = [file stringByAppendingPathComponent: filename];
    }
    return self;
}

-(id)GetKey:(NSString*)key
{
    data = [[NSMutableDictionary alloc] initWithContentsOfFile:file];
    return [data objectForKey: key];
}

-(void)UpdateKey:(NSString*)key val:(id)value
{
    data = [[NSMutableDictionary alloc] initWithContentsOfFile:file];
    [data setObject:value forKey:key];
    [data writeToFile:file atomically:NO];
    [data release];
}

-(void)DeleteKey:(NSString*)key
{
    data = [[NSMutableDictionary alloc] initWithContentsOfFile:file];
    [data removeObjectForKey:key];
    [data writeToFile:file atomically:NO];
    [data release];
}

-(void)InsertKey:(NSString*)key val:(id)value
{
    [self UpdateKey:key val:value];
}

@end
