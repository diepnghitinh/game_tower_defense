//
//  CBusiAKT.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiAKT.h"
#import "CBusiMap.h"

@implementation CBusiAKT

@synthesize grow, gcol, end;

-(id)initWithGraph:(NSMutableArray *)_graph enemy:(CBusiEnemy*)_enemy
{
    //gan bien
    if (self=[super init])
    {
        graph = _graph;
        //tinh tong cot vao tong dong trong matran
        grow = [[NSNumber numberWithUnsignedLong: [graph count]] intValue];
        gcol = [[NSNumber numberWithUnsignedLong: [[graph objectAtIndex: 0] count]] intValue];
        enemy = _enemy;
    }
    return self;
}

-(void)RemovePointToMap:(NSNumber*)point
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    //NSLog(@"point: %d", [point intValue]);
    NSMutableArray *arr = [busmap.enemysPath objectForKey: [NSString stringWithFormat:@"%d",[point intValue]]];
    
    if ([arr indexOfObject: enemy] != NSNotFound)
        [arr removeObject: enemy];
    
    if ([arr count] < 1)
        [busmap.enemysPath removeObjectForKey: [NSString stringWithFormat:@"%d",[point intValue]]];
}

-(void)ResetAllPoint
{
    //NSLog(@"path: %@", path);
    for (NSNumber *i in path)
    {
        [self RemovePointToMap: i];
    }
}

-(void)AddPointToMap:(NSNumber*)point
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    if ([busmap.enemysPath objectForKey: [NSString stringWithFormat:@"%d",[point intValue]]] == nil)
    {
        //them diem do vao cbus
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        [arr addObject: enemy];
        
        [busmap.enemysPath setObject:arr forKey:[NSString stringWithFormat:@"%d",[point intValue]]];
    }
    else
    {
        NSMutableArray *arr = [busmap.enemysPath objectForKey: [NSString stringWithFormat:@"%d",[point intValue]]];
        
        //NSMutableDictionary *dic
        if ([arr indexOfObject: enemy] == NSNotFound)
            [arr addObject: enemy];
    
    }
}

-(NSArray*)Solver:(int) start end: (int)_end method:(int)method
{
    if (enemy != nil)
        [self ResetAllPoint];
    
    //khai bao hang doi thong minh, biet bon chen
    CBusiAKTQueue *queue = [[[CBusiAKTQueue alloc] init] autorelease];
    
    //mang do dai canh lan can cua 1 node
    // * * *
    // * n *
    // * * *
    //canh cheo la a*sqrt(2)
    float distance[8] = {1.414214f, 1, 1.414214f, 1, 1, 1.414214f, 1 ,1.414214f};
    
    end = _end;
    
    //NSLog(@"g : %f", [[[graph objectAtIndex:3] objectAtIndex:9] floatValue]);
    
    //path duong di
    path = [[NSMutableArray alloc] init];
    
    //mang danh dau
    NSMutableDictionary *l = [[NSMutableDictionary alloc] init];
    
    //tinh khoang cach uoc luong h
    int h;
    h = [self Distance: start];
    
    //tao open dau tien
    NSMutableDictionary *n0 = [[NSMutableDictionary alloc] init];
    [self SetUpState:n0 g:[NSNumber numberWithFloat:0.0f] h:[NSNumber numberWithInt: h] i:[NSNumber numberWithInt: start] p:nil f:[NSNumber numberWithFloat: h]];
    //them node bat dau vao hang doi
    [queue Push: n0];
    [l setObject:@"1" forKey:[NSNumber numberWithInt:start ]];
    
    //bat dau tim duong
    while (![queue IsEmpty])
    {
        NSMutableDictionary *n = [queue Pop];
        
        //neu trang thai node la dich thi thoat
        if ([[n objectForKey:@"i"] intValue] == end)
        {
            //sau khi da co dich thi tu gia tri "p" da luu trang thai cua parent nen chi viec di lui lai
            while (n)
            {
                [path addObject:[n objectForKey:@"i"]];
                //them toa do path vao cbus
                if (enemy!=nil)
                    [self AddPointToMap: [n objectForKey:@"i"]];
                
                //buoc nhay
                n = [n objectForKey:@"p"];
            }
            //huy hang doi cho nhe
            [queue RemoveAll];
            break;
        }

        //nguoc lai tao ra trang thai lan can cua n
        // 5 6 7
        // 3 n 4
        // 0 1 2
        for (int j = 0; j < 8; ++j)
        {
            NSMutableDictionary *m = [[NSMutableDictionary alloc] init];
            int h,i;
            float g, f;
            //chi phi di dc hien tai
            g = [[n objectForKey:@"g"] floatValue] + distance[j];
            //i la diem hien tai, o day la diem lan can so voi huong cua n
            i = (method == 0 ? [self Relative:[[n objectForKey:@"i"] intValue] index:j] : [self RelativeAir:[[n objectForKey:@"i"] intValue] index:j]);
            //d la uoc luong chi phi
            h = [self Distance: i];
            //f la tong chi phi cua g va h uoc luong
            f = g + h;
            
            //NSLog(@"pop: %i,  %d,%d - f:%f", i, nrow, ncol, f);
            //cac dieu kien bo qua xet mot diem
            if (i == -1 || [l objectForKey:[NSNumber numberWithInt: i]] != nil)
                continue;
            
            [self SetUpState:m g:[NSNumber numberWithFloat:g] h:[NSNumber numberWithInt: h] i:[NSNumber numberWithInt: i] p:n f:[NSNumber numberWithFloat: f]];
            
            //them vao open
            [queue Push:m];
            //them vao roi danh dau
            [l setObject:@"1" forKey:[NSNumber numberWithInt: i]];
        }
    }
    
    return path;
}

-(int)RelativeAir:(int)node index:(int)index
{
    int pos = -1, nrow, ncol;
    
    nrow = node / gcol;
    ncol = node % gcol;
    
    switch (index)
    {
        case 0:
            if ([self CheckAirRelative:nrow + 1 col: ncol - 1])
                pos = node + gcol - 1;
            break;
        case 1:
            if ([self CheckAirRelative:nrow + 1 col: ncol])
                pos = node + gcol;
            break;
        case 2:
            if ([self CheckAirRelative:nrow + 1 col: ncol + 1])
                pos = node + gcol + 1;
            break;
        case 3:
            if ([self CheckAirRelative:nrow col: ncol - 1])
                pos = node - 1;
            break;
        case 4:
            if ([self CheckAirRelative:nrow col: ncol + 1])
                pos = node + 1;
            break;
        case 5:
            if ([self CheckAirRelative:nrow - 1 col: ncol - 1])
                pos = node - (gcol + 1);
            break;
        case 6:
            if ([self CheckAirRelative:nrow - 1 col: ncol])
                pos = node - gcol;
            break;
        case 7:
            if ([self CheckAirRelative:nrow - 1 col: ncol + 1])
                pos = node - (gcol - 1);
            break;
    }
    return pos;
    
}

-(int)Relative:(int)node index:(int)index
{
    int pos = -1, nrow, ncol;
    
    nrow = node / gcol;
    ncol = node % gcol;
    
    switch (index)
    {
        case 0:
            if ([self CheckRelative:nrow + 1 col: ncol - 1] && ([self CheckRelative:nrow + 1 col: ncol] || [self CheckRelative:nrow col: ncol - 1]) == YES)
                pos = node + gcol - 1;
            break;
        case 1:
            if ([self CheckRelative:nrow + 1 col: ncol])
                pos = node + gcol;
            break;
        case 2:
            if ([self CheckRelative:nrow + 1 col: ncol + 1] && ([self CheckRelative:nrow + 1 col: ncol] || [self CheckRelative:nrow col: ncol + 1]) == YES)
                pos = node + gcol + 1;
            break;
        case 3:
            if ([self CheckRelative:nrow col: ncol - 1])
                pos = node - 1;
            break;
        case 4:
            if ([self CheckRelative:nrow col: ncol + 1])
                pos = node + 1;
            break;
        case 5:
            if ([self CheckRelative:nrow - 1 col: ncol - 1] && ([self CheckRelative:nrow col: ncol - 1] || [self CheckRelative:nrow - 1 col: ncol]) == YES)
                pos = node - (gcol + 1);
            break;
        case 6:
            if ([self CheckRelative:nrow - 1 col: ncol])
                pos = node - gcol;
            break;
        case 7:
            if ([self CheckRelative:nrow - 1 col: ncol + 1] && ([self CheckRelative:nrow - 1 col: ncol] || [self CheckRelative:nrow col: ncol + 1]) == YES)
                pos = node - (gcol - 1);
            break;
    }
    
    return pos;
}

-(BOOL)CheckAirRelative:(int)row col:(int)col
{
    
    if (row > grow-1 || row < 0)
        return NO;
    if (col > gcol-1 || col < 0)
        return NO;
    
    //xet do thi chinh
    if ([[[graph objectAtIndex:row] objectAtIndex:col] intValue] == 1)
        return NO;
    
    return YES;
}

-(BOOL)CheckRelative:(int)row col:(int)col
{
    
    if (row > grow-1 || row < 0)
        return NO;
    if (col > gcol-1 || col < 0)
        return NO;
    
    //xet do thi chinh
    if ([[[graph objectAtIndex:row] objectAtIndex:col] intValue] == 1)
        return NO;
    
    //xet cac diem dat station
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    int index = [CGlobalMapGrid OffsetToIndex:row col:col];
    
    if ([busmap.stations objectForKey: [NSNumber numberWithInt: index]] != nil)
    {
        return NO;
    }
    
    //xet diem ban khi keo station vao
    if (busmap.estimatePoint != -1 && busmap.estimatePoint == index && enemy == nil)
        return NO;
    
    return YES;
}

-(void)SetUpState: (NSMutableDictionary *) n g:(id)g h:(id)h i:(id)i p:(id)p f:(id)f
{
    [n setValue:g forKey: @"g"];
    [n setValue:h forKey: @"h"];
    [n setValue:i forKey: @"i"];
    [n setValue:p forKey: @"p"];
    [n setValue:f forKey: @"f"];
}

-(int)Distance: (int)index
{
    int sr, sc, er, ec;
    
    sr = index / gcol;
    sc = index % gcol;
    
    er = end / gcol;
    ec = end % gcol;
    
    return abs(sr - er) + abs(sc -  ec);
}

@end
