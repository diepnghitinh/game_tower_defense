//
//  CBusiMap.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiMap.h"
#import "ShapeCircle.h"
#import "CBusiSkill.h"
#import "CGlobalEffectMapResult.h"
#import "CBusiSprite.h"
//#import "GlobalVariables.h"

@implementation CBusiMap

@synthesize content, maparray, mapid, mapinfo, stations, enemys, busys, items, enemysLength, enemysSorted, estimatePoint, enemysPath;
@synthesize camera2D;
@synthesize time;
@synthesize isEnemyLive;

-(id) init:(int)name
{
    if (self=[super init])
    {
        //khoi tao cac thong tin cho map
        CDataMap *map = [[[CDataMap alloc] initWithMap: name] autorelease];
        mapinfo = [[CInfoMap alloc] init];
        mapinfo = [map mapinfo];
        maparray = mapinfo.maparray;
        mapid = name;
        stations = [[NSMutableDictionary alloc] init];
        enemys = [[NSMutableDictionary alloc] init];
        busys = [[NSMutableDictionary alloc] init];
        enemysLength = [[NSMutableDictionary alloc] init];
        enemysPath = [[NSMutableDictionary alloc] init];
        
        enemysSorted = [[NSMutableArray alloc] init];
        items = [[NSMutableArray alloc] init];
        //xet lai globalmap grid
        [CGlobalMapGrid SetRow: mapinfo.row];
        [CGlobalMapGrid SetCol: mapinfo.col];
        //thoi gian bat dau
        time = 0;
        //cap nhat thong tin wave
        tenemy = [mapinfo.enemys count];
        cenemy = 0;
        //diem uoc luong khi keo vat pham vao
        estimatePoint = -1;
    }
    return self;
}

-(id) initWithMap:(int)name
{
    [self init:name];
    return self;
}

-(void) initWithCamera:(CGlobalCamera2D *)camera
{
    content = camera.content;
    camera2D = camera;

    //cap nhat tat ca station
    for (id key in stations)
    {
        id value = [stations objectForKey:key];
        [value Exec: camera coordinate: [key intValue]];
        //them layer station vao map de xu ly click cham
        [self addChild:value];
    }
    
    //debug map
    /*
    for (int i = 17, e = 0; i >= 0; --i, ++e)
    {
        for (int j = 0; j < 24; ++j)
        {
            if ([[maparray objectAtIndex: e] objectAtIndex: j] == [NSNumber numberWithInt:1])
            {
                CCSprite *blank = [CCSprite spriteWithFile:@"blank.jpg"];
                [blank setTextureRect:CGRectMake(0, 0, tileSize, tileSize)];
                [blank setPosition: [CGlobalMapGrid IndexToCoor: [CGlobalMapGrid OffsetToIndex: e col: j]]];
                [blank setOpacity: 150];
                [camera.layer addChild: blank];                   
            }
        }
           
    }*/
    
    [self schedule:@selector(UpdateTime:) interval:1];
    [self schedule:@selector(UpdateObjects:) interval:0.03];
}

-(void) addStation:(id)station index:(int)index
{
    if ([stations objectForKey:[NSNumber numberWithInt:index]] == nil)
    {
        [stations setObject:station forKey:[NSNumber numberWithInt:index]];
        id value = [stations objectForKey:[NSNumber numberWithInt:index]];
        [value Exec:camera2D coordinate:index];
        //add child de co the su dung dc touch event
        [self addChild:value];
    }
}

-(void) removeStation:(id)station
{
    if ([stations objectForKey:station] != nil)
    {
        [[[stations objectForKey: station] body] removeFromParentAndCleanup: YES] ;
        [stations removeObjectForKey: station];
    }
}

-(void) addEnemy:(id)enemy Id:(NSString*)Id index:(int)index
{
    //id chinh la thoi gian enemy dc add vao
    ((CBusiEnemy*)enemy).info.Id = Id;
    [enemys setObject:enemy forKey:Id];
    //nghich tao toa do tao zindex

    if ([((CBusiEnemy*)enemy).info isKindOfClass: [CInfoEnemyGround class]])
        [camera2D.content addChild: enemy z: [CGlobalMapGrid InverseCoorY:((CBusiEnemy*)enemy).position].y];
    else
        [camera2D.airlayer addChild: enemy z: [CGlobalMapGrid InverseCoorY:((CBusiEnemy*)enemy).position].y];
    
    cenemy++;
}

-(void) removeEnemy:(id)enemy
{
    if (enemy != nil && ((CBusiEnemy*)enemy).dead == YES)
    {
        //NSLog(@"remove id: %@",((CBusiEnemy*)enemy).info.Id);
        [enemys removeObjectForKey: ((CBusiEnemy*)enemy).info.Id];
        [enemy removeAllChildrenWithCleanup: YES];
        [enemy removeFromParentAndCleanup: YES];
        //remove khoi sort
        [enemysLength removeObjectForKey: ((CBusiEnemy*)enemy).info.Id];
        [enemysSorted removeObject: ((CBusiEnemy*)enemy).info.Id];
    }
}

-(void) addSkill:(id)skill coor:(CGPoint)point
{
    [skill Core:camera2D coordinate:point];
}

-(id) getTypeEnemy: (id)i
{
    
    id object;
    int type = [[i objectForKey:@"type"] intValue];
    CInfoEnemy *info;
    
    switch (type)
    {
        case 1:
            info = [[[CInfoEnemy1 alloc] init] autorelease];
            object = [[CBusiEnemy1 alloc] initWithInfo:info];
            break;
        case 2:
            info = [[[CInfoEnemy2 alloc] init] autorelease];
            object = [[CBusiEnemy2 alloc] initWithInfo:info];
            break;
        case 3:
            info = [[[CInfoEnemy3 alloc] init] autorelease];
            object = [[CBusiEnemy3 alloc] initWithInfo:info];
            break;
        case 4:
            info = [[[CInfoEnemy4 alloc] init] autorelease];
            object = [[CBusiEnemy4 alloc] initWithInfo:info];
            break;
        case 5:
            info = [[[CInfoEnemy5 alloc] init] autorelease];
            object = [[CBusiEnemy5 alloc] initWithInfo:info];
            break;
        case 6:
            info = [[[CInfoEnemy6 alloc] init] autorelease];
            object = [[CBusiEnemy6 alloc] initWithInfo:info];
            break;
        default:
            break;
    }
    
    return object;
}

-(void)UpdateTime:(ccTime)dt
{
    //NSLog(@"thoi gian: %ld", time);
    
    //them enemy neu dung thoi gian chi dung trong plist
    id arr = [mapinfo.enemys objectForKey: [NSString stringWithFormat:@"%d", time]];
    int index = 0;
    
    //update thong tin top info
    if ([arr count] > 0)
        [self UpdateWave];
    
    for (id i in arr)
    {
        CBusiEnemy *enemy = [self getTypeEnemy: i];
        enemy.info.level = [[i objectForKey:@"level"] intValue];
        //so mau cua enemy se bang level * base health
        enemy.health = enemy.info.level*enemy.info.health;
        enemy.cost = enemy.info.level*enemy.info.cost;
        enemy.info.Id = [NSString stringWithFormat:@"%d-%d", time, index];
        
        [enemy Exec:camera2D coordinate: mapinfo.start];
        //them enemy vao diem bat dau
        [self addEnemy:enemy Id:[NSString stringWithFormat:@"%d-%d", time, index ] index: mapinfo.start];
        index++;
        [enemy release];
    }
    
    time += dt;
}

//kiem tra xem xem tren ban do con enemy nao hay ko
-(BOOL)IsHaveEnemy
{
    for (id i in enemys) {
        if ([[enemys objectForKey: i] deading] == NO)
            return NO;
    }
    return YES;
}

-(void)UpdateObjects:(ccTime)dt
{
    /*
    NSLog(@"path===============");
    for (id i in enemysPath)
    {
        NSLog(@"%@ ,- %d", i, [[enemysPath objectForKey: i] count]);
    }
    */
    //update station: ham update dung chung
    for (id i in stations) {
        [[stations objectForKey: i] UpdateLogic:dt];
    }
    
    //kiem tra thang thua
    if (cenemy >= tenemy && mapinfo.health > 0)
    {
        if (![self IsHaveEnemy])
            return;
        
        //nguoc lai thi cho animation thang, 0 la thang, 1 la thua
        [CGlobalEffectMapResult actionWithMethod: 0];
        return;
    }
    
    if (mapinfo.health < 1)
        [CGlobalEffectMapResult actionWithMethod: 1];
}

-(void)UpdateWave
{
    mapinfo.wave++;
    [[CGlobalLayer GetLayer:@"mapmenu"] UpdateWave];
};

-(void)UpdateCost
{
    [[CGlobalLayer GetLayer:@"mapmenu"] UpdateCost];
};

-(void)UpdateHealth
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"health-down.mp3"];
    [[CGlobalLayer GetLayer:@"mapmenu"] UpdateHealth];
};

-(void)dealloc
{
    NSLog(@"busimap dealloc");
    [mapinfo release];  
    [super dealloc];
}

@end
