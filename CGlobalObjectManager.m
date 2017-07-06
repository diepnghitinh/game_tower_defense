//
//  CGlobalObjectManager.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalObjectManager.h"
#import "SimpleAudioEngine.h"
#import "CBusiMap.h"
#import "CBusiStation1.h"
#import "CBusiStation2.h"
#import "CBusiStation3.h"
#import "CBusiStation5.h"
#import "CBusiStation4.h"
#import "CBusiStation6.h"
#import "CBusiSkill1.h"
#import "CBusiSkill2.h"
#import "CBusiSkill3.h"
#import "CBusiSkill4.h"

@implementation CGlobalObjectManager

@synthesize UnlockObject = objects, FirstObject = fobjects; 

-(id)init
{
    if (self=[super init])
    {
        //cap nhat danh sach thu tu cac object kich hoat theo thu tu
        objects = [[NSMutableDictionary alloc] init];
        [objects setValue:[[CInfoStation1 alloc] init] forKey:@"0"];
        [objects setValue:[[CInfoStation2 alloc] init] forKey:@"1"];
        [objects setValue:[[CInfoStation3 alloc] init] forKey:@"2"];
        [objects setValue:[[CInfoSkill1 alloc] init] forKey:@"3"];
        [objects setValue:[[CInfoSkill2 alloc] init] forKey:@"4"];
        [objects setValue:[[CInfoStation6 alloc] init] forKey:@"5"];
        [objects setValue:[[CInfoStation4 alloc] init] forKey:@"6"];
        [objects setValue:[[CInfoStation5 alloc] init] forKey:@"7"];
        [objects setValue:[[CInfoSkill3 alloc] init] forKey:@"8"];
        [objects setValue:[[CInfoSkill4 alloc] init] forKey:@"9"];
        
        //hinh anh se hien thi dau tien khi dat object
        fobjects = [[NSMutableDictionary alloc] init];
        [fobjects setValue:@"424-3.png" forKey:@"0"];
        [fobjects setValue:@"591-3.png" forKey:@"1"];
        [fobjects setValue:@"179-3.png" forKey:@"2"];
        [fobjects setValue:@"" forKey:@"3"];
        [fobjects setValue:@"" forKey:@"4"];
        [fobjects setValue:@"370-3.png" forKey:@"5"];
        [fobjects setValue:@"221-3.png" forKey:@"6"];
        [fobjects setValue:@"206-3.png" forKey:@"7"];
        [fobjects setValue:@"" forKey:@"8"];
        [fobjects setValue:@"" forKey:@"9"];
        
    }
    return self;
}

-(CInfoObject*)GetObject:(int)objectIndex
{
    return [objects objectForKey: [NSString stringWithFormat: @"%d", objectIndex] ];
}

-(void)CreateObject:(int)objectIndex coor:(CGPoint)point delay:(int *)val
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    id cbus = nil;
    
    switch (objectIndex)
    {
        case 0:
            cbus = [[CBusiStation1 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addStation:cbus index: [CGlobalMapGrid CoorToIndex:point]];
                *val = ((CBusiStation*)cbus).info.delay;
                busmap.mapinfo.cost -= ((CBusiStation*)cbus).info.cost;
                [busmap UpdateCost];
            }
            break;
        case 1:
            cbus = [[CBusiStation2 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addStation:cbus index: [CGlobalMapGrid CoorToIndex:point]];
                *val = ((CBusiStation*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiStation*)cbus).info.cost;
                [busmap UpdateCost];
            }
            break;
        case 2:
            cbus = [[CBusiStation3 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addStation:cbus index: [CGlobalMapGrid CoorToIndex:point]];
                *val = ((CBusiStation*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiStation*)cbus).info.cost;
                [busmap UpdateCost];
            }
            break;
        case 3:
            cbus = [[CBusiSkill1 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addSkill:cbus coor:point];
                *val = ((CBusiSkill*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiSkill*)cbus).info.cost;
                [busmap UpdateCost];
                
                //am thanh
                [[SimpleAudioEngine sharedEngine] playEffect: @"skill-1.wav"];
            }
            break;
        case 4:
            cbus = [[CBusiSkill2 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addSkill:cbus coor:point];
                *val = ((CBusiSkill*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiSkill*)cbus).info.cost;
                [busmap UpdateCost];
                
                //am thanh
                [[SimpleAudioEngine sharedEngine] playEffect: @"skill-2.wav"];
            }
            break;
        case 5:
            cbus = [[CBusiStation6 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addStation:cbus index: [CGlobalMapGrid CoorToIndex:point]];
                *val = ((CBusiStation*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiStation*)cbus).info.cost;
                [busmap UpdateCost];
            }
            break;
        case 6:
            cbus = [[CBusiStation4 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addStation:cbus index: [CGlobalMapGrid CoorToIndex:point]];
                *val = ((CBusiStation*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiStation*)cbus).info.cost;
                [busmap UpdateCost];
            }
            break;
        case 7:
            cbus = [[CBusiStation5 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addStation:cbus index: [CGlobalMapGrid CoorToIndex:point]];
                *val = ((CBusiStation*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiStation*)cbus).info.cost;
                [busmap UpdateCost];
            }
            break;
        case 8:
            cbus = [[CBusiSkill3 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addSkill:cbus coor:point];
                *val = ((CBusiSkill*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiSkill*)cbus).info.cost;
                [busmap UpdateCost];
                
                //am thanh
                [[SimpleAudioEngine sharedEngine] playEffect: @"skill-3.wav"];
            }
            break;
        case 9:
            cbus = [[CBusiSkill4 alloc] init];
            if (busmap.mapinfo.cost - [[cbus info] cost] >= 0)
            {
                [busmap addSkill:cbus coor:point];
                *val = ((CBusiSkill*)cbus).info.delay;
                
                busmap.mapinfo.cost -= ((CBusiSkill*)cbus).info.cost;
                [busmap UpdateCost];
                
                //am thanh
                [[SimpleAudioEngine sharedEngine] playEffect: @"skill-4.wav"];
            }
            break;
    }
}

@end
