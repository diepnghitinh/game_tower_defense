//
//  CBusiEnemy.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiEnemy.h"
#import "CBusiMap.h"
#import "CGlobalActionEnemyMove.h"
#import "GlobalVariables.h"

@implementation CBusiEnemy

@synthesize index=_index, info, dead=Dead, deading = Deading, health, cost, body, nextMove, path;
@synthesize statusEffect;

-(id)init
{
    if (self=[super init])
    {
        //mac dinh trang thai station la normal 
        status = emove7;
        moving = YES;
        busmap = [(CBusiMap*)[CGlobalVariables GetMapPlay] autorelease];
        finding = [[CBusiAKT alloc] initWithGraph:((CBusiMap*)busmap).maparray enemy:self];
        //danh sach duong di
        path = [NSArray array];
        //hp bar
        hpBar = [CCProgressTimer progressWithFile:@"bar-health.png"];
        hpBar.type = kCCProgressTimerTypeHorizontalBarLR;
        //ve ong mau
        [hpBar setPercentage:100];
        //trang thai binh thuong cho enemy
        statusEffect = enormal;
        //thoi gian phan huy
        timeTrash = 10.0f;
        elapsed = 0.0f;
        [self setContentSize: CGSizeMake(tileSize, tileSize)];
        [self setAnchorPoint: ccp(0, 0)];
    }
    return self;
}

-(id)initWithInfo:(CInfoEnemy*)enemy
{
    info = [[CInfoEnemy alloc] init];
    info = enemy;
    return [self init];
}

//phuong thuc them diem ban
-(void)AddBusy:(int)index_
{
    
    if (method == 1)
        return;
    
    NSMutableArray *data = [((CBusiMap*)busmap).busys objectForKey:[NSNumber numberWithInt: index_]];
    
    if (data == nil)
    {
        [((CBusiMap*)busmap).busys setObject:[[NSMutableArray alloc] initWithObjects: info.Id, nil] forKey:[NSNumber numberWithInt: index_]];
    }
    else
    {
        if ([data indexOfObject:info.Id] == NSNotFound)
            [data addObject: info.Id];
    }
}

-(void)RemoveBusy:(int)index_
{ 
    
    if (method == 1)
        return;
    
    [[((CBusiMap*)busmap).busys objectForKey:[NSNumber numberWithInt: index_]] removeObject: info.Id];

    if ([[((CBusiMap*)busmap).busys objectForKey:[NSNumber numberWithInt: index_]] count] < 1)
    {
        [((CBusiMap*)busmap).busys removeObjectForKey: [NSNumber numberWithInt: index_]];
    }
}

-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index_
{
    //set camera2D
    camera2D = camera;
    [self setPosition: [CGlobalMapGrid IndexToCoor: index_]];
    //set index hien tai cua enemy
    _index = index_;
    nextMove = _index;
    //xet diem ban
    [self AddBusy:index_];
    //ve mau vao sprite
    hpBg = [CCSprite spriteWithFile:@"bar-health-border.png"];
    [hpBar setPosition: ccp(hpBg.contentSize.width/2, hpBg.contentSize.height/2)];
    [hpBg addChild: hpBar];
    [self addChild: hpBg];
}

-(void)moveEnd
{
    [self RemoveBusy:_index];
    _index = nextMove;
    moving = YES;
}

-(void)RefreshHealth
{
    if (health <= 0)
    {
        //cho no chet
        health = 0;
        Deading = YES;
        [self Kill];
        //them tien vao bus
        ((CBusiMap*)busmap).mapinfo.cost += info.cost*info.level;
        [busmap UpdateCost];
    }
    [hpBar setPercentage: (float)(health*100)/(info.health*info.level)];
}

-(BOOL)Kill
{
    if (Deading == YES)
    {
        [self setVisible: NO];
        [self stopAllActions];
        //remove busy
        [self RemoveBusy: _index];
        [self RemoveBusy: nextMove];
        return NO;
    }
    
    if (Dead == YES)
    {
        [self setVisible: NO];
        [busmap removeEnemy:self];
        [self RemoveBusy: _index];
        [self RemoveBusy: nextMove];
        return YES;
    }
    
    return NO;
}

-(void)Hits:(int)damage
{
    //damage effect
    CCLabelTTF *_damage = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", damage] fontName:@"Arial" fontSize:20];
    [_damage setColor: ccc3(223, 53, 57)];
    //miss set
    [_damage setPosition: self.position];
    [camera2D.layer addChild: _damage];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5 position:ccp(self.position.x, self.position.y + 50)];
    id actions = [CCSequence actions: moveAction, [CCCallFunc actionWithTarget:_damage selector:@selector(removeFromParentAndCleanup:)],nil];
    [_damage runAction:actions];
    
    health -= damage;
    
    [self RefreshHealth];
    //??? co remove hay ko?? kill enemy
    //NSLog(@"cdead: %u - health: %d - dead: %@", cdead, health, Dead ? @"yes" : @"no");
    [self Kill];
}

-(void)DrawStatus
{
    switch (status)
    {
        case emove1:
            //action
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"move1"] delay:0.1f]]];
            [body runAction:action];
            break;
        case emove2:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"move2"] delay:0.1f]]];
            [body runAction:action];
            break;
        case emove3:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"move3"] delay:0.1f]]];
            [body runAction:action];
            break;
        case emove4:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"move4"] delay:0.1f]]];
            [body runAction:action];
            break;
        case emove5:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"move5"] delay:0.1f]]];
            [body runAction:action];
            break;
        case emove6:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"move6"] delay:0.1f]]];
            [body runAction:action];
            break;
        case emove7:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"move7"] delay:0.1f]]];
            [body runAction:action];
            break;
        case emove8:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"move8"] delay:0.1f]]];
            [body runAction:action];
            break;
        default:
            break;
    }
}

-(void)SortEnemysLength:(NSArray*)path_
{
    [((CBusiMap*)busmap).enemysLength setObject:[NSNumber numberWithInt:[path_ count]] forKey: info.Id];
    ((CBusiMap*)busmap).enemysSorted =[[NSMutableArray alloc] initWithArray:   
                                       [((CBusiMap*)busmap).enemysLength keysSortedByValueUsingComparator:^(id obj1, id obj2)
                                        {
                                            if ([obj1 intValue] < [obj2 intValue])
                                                return (NSComparisonResult)NSOrderedAscending;
                                            
                                            if ([obj1 intValue] > [obj2 intValue])
                                                return (NSComparisonResult)NSOrderedDescending;
                                            return (NSComparisonResult)NSOrderedSame;
                                        }]];
}

-(void)UpdateLogic:(ccTime)dt
{
    //NSLog(@"position: %f - %f", body.position.x , body.position.y);
    
    //neu deading , thi bat dau phan huy
    if (Deading)
    {
        [self MoveTrash: dt];
        [finding RemovePointToMap: [NSNumber numberWithInt:_index]];
        [finding RemovePointToMap: [NSNumber numberWithInt:nextMove]];
        return;
    }
    
    //neu co station keo vao map group thi kiem tra do uoc luong cua tat ca
    /*
    if (((CBusiMap*)busmap).estimatePoint != -1 && method == 0)
    {
        EstimatePath = [finding Solver:_index end: ((CBusiMap*)busmap).mapinfo.end method: method estimate:YES];
        if ([EstimatePath count] == 0)
        {
            if ([((CBusiMap*)busmap).enemysNotPath indexOfObject:info.Id] == NSNotFound)
                [((CBusiMap*)busmap).enemysNotPath addObject: info.Id];
        }
        else
        {
            if ([((CBusiMap*)busmap).enemysNotPath indexOfObject:info.Id] != NSNotFound)
                [((CBusiMap*)busmap). enemysNotPath removeObject: info.Id];
        }
    }*/
    
    if (nextMove == _index)
    {
        path = [finding Solver:_index end: ((CBusiMap*)busmap).mapinfo.end method: method];
    }

    if ([path count] > 1)
    {
        nextMove = [[path objectAtIndex: [path count] - 2] intValue];
        //danh dau diem ban
        [self AddBusy: nextMove];
        //cap nhat enemy sort
        [self SortEnemysLength: path];
    }
    else
        nextMove = _index;
    
    //neu enemy da den dich thi remove
    if (_index == ((CBusiMap*)busmap).mapinfo.end)
    {
        if (Deading == NO)
        {
            //- mau tai cbus
            if (((CBusiMap*)busmap).mapinfo.health-1 >= 0)
            {
                ((CBusiMap*)busmap).mapinfo.health--;
                [busmap UpdateHealth];
            }
        }
        //cho trang thai chet, nhung khong chet han
        Deading = YES;
        [self Kill];        
        return;
    }
    
    if (nextMove != _index && moving)
    {
        //gan action move co' toc doc di chuyen info.speed
        id move = [CGlobalActionEnemyMove actionWithDuration:info.speed position:[CGlobalMapGrid IndexToCoor: nextMove]];
        move = [CCSequence actions:move, [CCCallFunc actionWithTarget:self selector:@selector(moveEnd)], nil];
        //di chuyen co tag == 0
        [move setTag: 0];
        
        [self runAction:move];
        
        //xet lai trang thai di chuyen
        if (_index == nextMove - finding.gcol +1)
            status = emove1;
        if (_index == nextMove - finding.gcol)
            status = emove2;
        if (_index == nextMove - finding.gcol -1)
            status = emove3;
        
        if (_index == nextMove + 1)
            status = emove4;
        if (_index == nextMove - 1)
            status = emove5;
        
        if (_index == nextMove + finding.gcol + 1)
            status = emove6;
        if (_index == nextMove + finding.gcol)
            status = emove7;
        if (_index == nextMove + finding.gcol - 1)
            status = emove8;

        [self DrawStatus];
        moving = NO;
    }
}

-(void)MoveTrash:(ccTime)t
{
    elapsed += t;
    if (elapsed >= timeTrash)
    {
        //phan huy xac chet
        Deading = NO;
        Dead = YES;
        [self Kill];
    }
}

-(CCNode*)getParent
{
    return parent_;
}

@end
