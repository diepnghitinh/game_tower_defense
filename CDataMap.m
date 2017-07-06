//
//  CDataMap.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CDataMap.h"

@implementation CDataMap

@synthesize mapinfo;

-(id)initWithMap:(int)name
{
    if (self=[super init])
    {
        
        CDataDatabase *connect = [[CDataDatabase alloc] initWithFile:[NSString stringWithFormat:@"map_%d.plist",name]];
        
        switch (name) {
            case 0:
                mapinfo = [[CInfoMap0 alloc] init];
                break;
            case 1:
                mapinfo = [[CInfoMap1 alloc] init];
                break;
            case 2:
                mapinfo = [[CInfoMap2 alloc] init];
                break;
            case 3:
                mapinfo = [[CInfoMap3 alloc] init];
                break;
            case 4:
                mapinfo = [[CInfoMap4 alloc] init];
                break;
        }
        
        mapinfo.cost = [[connect GetKey:@"cost"] intValue];
        mapinfo.name = [connect GetKey:@"name"];
        mapinfo.bg = [CCSprite spriteWithFile: [connect GetKey:@"bg"]];        
        mapinfo.enemys = [connect GetKey:@"enemys"];
        mapinfo.itemUnlock = [[connect GetKey:@"itemunlock"] intValue];
        
    }
    return self;
}

@end
