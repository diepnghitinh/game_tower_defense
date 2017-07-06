//
//  CBusiAKTQueue.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiAKTQueue.h"

@implementation CBusiAKTQueue

@synthesize data;

-(id)init
{
    if (self=[super init])
    {
        data = [[NSMutableArray alloc] init];
    }
    return self;
}

-(BOOL)IsEmpty
{
    if (data.count == 0)
        return YES;
    return NO;
}

-(void)RemoveAll
{
    [data removeAllObjects];
}

-(id)Pop
{
    if ([self IsEmpty])
        return nil;
    
    id tmp = [[data objectAtIndex: 0] copy];
    
    [data removeObjectAtIndex: 0];
    
    return tmp;
}

-(void)Push: (NSMutableDictionary*)node
{
    [data addObject: node];
    
    int count = [[NSNumber numberWithUnsignedLong: [data count]] intValue];
    
    //khi them phan tu vao hang doi, no se tu chen len dinh dau voi dieu kien do uu tien "f" la nho nhat
    for (int i = count - 1; i > 0; --i)
    {
        if ([[[data objectAtIndex: i] objectForKey:@"f"] floatValue] < [[[data objectAtIndex:i-1] objectForKey:@"f"] floatValue])
        {
            //hoan vi 2 phan tu gan nhau
            id tmp = [data objectAtIndex: i];
            [data replaceObjectAtIndex:i withObject:[data objectAtIndex: i-1]];
            [data replaceObjectAtIndex:i-1 withObject:tmp];
        }
    }
}

@end
