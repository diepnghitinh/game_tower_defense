//
//  CControlMenuItem.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CControlMenuItem.h"
#import "GlobalVariables.h"
#import "CGlobalActionDelayItem.h"
#import "CInfoSkill.h"
//#import "DialogBox.h"
//#import "DialogAddItem.h"
#import "CBusiAKT.h"

static NSNumber *itemClicked = nil;

@implementation CControlMenuItem

@synthesize item, isClick, isUse;
@synthesize bounding=_bounding;

-(id)initWithItem:(int)i
{
    if (self=[super init])
    {
        if (iPad)
            item = [CCSprite spriteWithFile: [NSString stringWithFormat:@"ipad-icon-%d.png", i ]];
        else
            item = [CCSprite spriteWithFile:[NSString stringWithFormat:@"iphone-icon-%d.png", i ]];
        itemIndex = i;
        [self addChild: item];
        
        objectManager = [[CGlobalObjectManager alloc] init];
        busmap = [[CGlobalVariables GetMapPlay] autorelease];
        
        [self schedule:@selector(UpdateLogic) interval:0.03];
    }
    return self;
}

-(void)UpdateLogic
{
    if (isUse)
    {
        if (circle == nil || rect ==nil)
            return;
        
        if (isDraw == NO)
            return;
        
        if (![self CheckBuilt: point])
        {
            [circle RefreshColor:ccc4(255, 0, 0, 0)];
            [rect setColor:ccc3(255, 0, 0)];
        }
        else
        {
            [circle RefreshColor:ccc4(0, 255, 0, 0)];
            [rect setColor:ccc3(0, 255, 0)];
        }
    }
}

-(void)SetChecked:(BOOL)val
{
    if (val == YES)
    {
        [item removeFromParentAndCleanup: YES];
        if (iPad)
            item = [CCSprite spriteWithFile: [NSString stringWithFormat:@"ipad-icon-%d-hover.png", itemIndex ]];
        else
            item = [CCSprite spriteWithFile:[NSString stringWithFormat:@"iphone-icon-%d-hover.png", itemIndex ]];
        [self addChild: item];
    }
    else
    {
        [item removeFromParentAndCleanup: YES];
        if (iPad)
            item = [CCSprite spriteWithFile: [NSString stringWithFormat:@"ipad-icon-%d.png", itemIndex ]];
        else
            item = [CCSprite spriteWithFile:[NSString stringWithFormat:@"iphone-icon-%d.png", itemIndex ]];
        [self addChild: item]; 
    }
}

-(void)SetBounding
{
    CGPoint coor = ccpAdd(self.boundingBox.origin, [self parent].position);
    _bounding = CGRectMake(coor.x - item.boundingBox.size.width/2, coor.y - item.boundingBox.size.height/2, item.boundingBox.size.width, item.boundingBox.size.height);
}

//kiem tra xem cell do co cho xay object hay khong
-(BOOL)CheckBuilt:(CGPoint)point_
{
    int index = [CGlobalMapGrid CoorToIndex:point_];
    return ![self IsHaveObject: index];
}

BOOL isPath;

//phuong thuc kiem tra duong di, yes => red, no: green
-(BOOL)CheckPath
{
    
    NSMutableArray *checked = [[NSMutableArray alloc] init];
    CBusiAKT *finding = [[CBusiAKT alloc] initWithGraph:busmap.maparray enemy:nil];
    
    if (isPath == YES)
    {
        if (tmpPath != busmap.estimatePoint)
        {
            //kiem tra tu diem di chuyen dau
            NSArray *path = [finding Solver:busmap.mapinfo.start end: busmap.mapinfo.end method: 0];
            
            tmpPath = busmap.estimatePoint;
            
            if ([path count] > 0)
            {
                isPath = NO;
                return NO;
            }
        }
        return YES;
    }
    
    if (tmpPath != busmap.estimatePoint)
    {
        
        //NSLog(@"drag: %d - %@", busmap.estimatePoint, [busmap.enemysPath objectForKey: [NSString stringWithFormat: @"%d", busmap.estimatePoint]]);
        
        //kiem tra tu diem di chuyen dau
        NSArray *path = [finding Solver:busmap.mapinfo.start end: busmap.mapinfo.end method: 0];
        
        tmpPath = busmap.estimatePoint;
        
        if ([path count] == 0)
        {
            isPath = YES;
            return YES;
        }
        
        NSMutableArray *arr = [busmap.enemysPath objectForKey: [NSString stringWithFormat: @"%d", busmap.estimatePoint]];
        
        for (CBusiEnemy *i in arr) {
            
            int indexOf = [i.path indexOfObject: [NSNumber numberWithInt: busmap.estimatePoint]], prevIndexOf;
            
            if ((prevIndexOf = indexOf + 1) > [i.path count] - 1)
                prevIndexOf = indexOf;
            
            //to cell index
            int cell = [[i.path objectAtIndex: prevIndexOf] intValue];
            
            if ([checked indexOfObject: [NSString stringWithFormat:@"%d",cell]] != NSNotFound)
                continue;
            
            //NSLog(@"s: %d - %d", cell, busmap.estimatePoint);
            NSArray *path = [finding Solver:cell end: busmap.mapinfo.end method: 0];
            //NSLog(@"count: %d", [path count]);
            
            if ([path count] == 0)
            {
                if ([checked indexOfObject: [NSString stringWithFormat:@"%d",cell]] == NSNotFound)
                    [checked addObject: [NSString stringWithFormat:@"%d",cell]];
                
                tmpPath = busmap.estimatePoint;
                
                return YES;
            }
        }
    }
    
    tmpPath = busmap.estimatePoint;

    return NO;
}

//kiem tra xem xem tai index do co' object hay chua
-(BOOL)IsHaveObject:(int)index
{
    CGPoint p = [CGlobalMapGrid IndexToOffset:index];
        
    id object = [[busmap.maparray objectAtIndex: p.x] objectAtIndex: p.y];
    
    if ((object != nil && [object intValue] == 1) || [busmap.busys objectForKey: [NSNumber numberWithInt: index]] != nil || [busmap.stations objectForKey: [NSNumber numberWithInt: index]] != nil || busmap.mapinfo.end == index || [self CheckPath] == YES)
    {
        return YES;
    }
    return NO;
}

//kiem tra xem xem co swap menu hay ko
-(BOOL)isSwapMenu:(UITouch *)touch
{
    
    CGPoint pclick = [touch locationInView: [touch view] ];
    pclick = [[CCDirector sharedDirector] convertToGL: pclick];
    
    //remove tat ca cac isClick cua cac menu khac
    for (int i = 0; i < [busmap.items count]; ++i)
    {
        id menuParent = [[CGlobalLayer GetLayer:@"mapmenu"] getChildByTag:i];
        //NSLog(@"bounding2-%d %f-%f", [menuParent tag] ,[menuParent bounding].origin.x, [menuParent bounding].origin.y);
        if (CGRectContainsPoint([menuParent bounding], pclick))
        {
            return NO;
        }
    }
    return YES;
}

//lay hinh anh item tu index item
-(CCSprite*)GetSprite:(int)index
{
    NSString *name = [objectManager.FirstObject objectForKey: [NSString stringWithFormat:@"%d", index]];
    
    if (name != @"")
    {
        CCSpriteFrame *frameName = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: name ];
        CCSprite *sprite = [CCSprite spriteWithSpriteFrame: frameName];

        return sprite;
    }
    return nil;
}

//lay hinh anh item tu index item
-(CInfoObject*)GetType:(int)index
{
    return [objectManager.UnlockObject objectForKey: [NSString stringWithFormat:@"%d", index]];
}

- (void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:NO];
    [super onEnter];
}

- (void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    //NSLog(@"-begin: %d", itemIndex);
    
    CGPoint pclick = [touch locationInView: [touch view] ];
    pclick = [[CCDirector sharedDirector] convertToGL: pclick];
    //point hien tai tren camera map
    CGPoint p = [busmap.camera2D.view convertTouchToNodeSpace:touch];

    /*
    NSLog(@"menu %d: ", itemIndex);
    NSLog(@"toa do: %f, %f", self.boundingBox.origin.x, self.boundingBox.origin.y);
    NSLog(@"click: %f, %f", pclick.x, pclick.y);
    NSLog(@"rect: %f, %f, %f, %f", _bounding.origin.x, _bounding.origin.y, _bounding.size.width,  _bounding.size.height);
    */
    
    //NSLog(@"bounding1-%d %f-%f", itemIndex, _bounding.origin.x, _bounding.origin.y);
    
    id obj = [objectManager GetObject: itemIndex];
    //neu item menu dang o dang delay thi khong thuc thi
    
    //NSLog(@"isdelay: %@ - obj: %d", isDelay ? @"yes" : @"no", itemIndex);    
    
    //item da duoc click
    if (CGRectContainsPoint(_bounding, pclick))
    {
        
        isUse = YES;
        //nguoc lai thi enable touch tai mapgroup di
        //dis scroll view camera cua layer mapgroup
        [[CCTouchDispatcher sharedDispatcher] removeDelegate: [CGlobalLayer GetLayer:@"mapground"] ];
        
        //neu dang delay thi bao loi
        if (isDelay)
        {
            isError = YES;
            [[SimpleAudioEngine sharedEngine] playEffect: @"warning.mp3"];
            return YES;
        }
        
        //neu khong du tien cung bao loi luon
        if ((busmap.mapinfo.cost - [obj cost]) < 0)
        {
            isError = YES;

            [[SimpleAudioEngine sharedEngine] playEffect: @"warning.mp3"];
            return YES;
        }
        
        if (itemIndex == [itemClicked intValue] && itemClicked != nil)
        {
            //remove toggle
            NSLog(@"remove %d toggle", itemIndex);
            //doi lai mau binh thuong cho button
            id menuParent = [[CGlobalLayer GetLayer:@"mapmenu"] getChildByTag:self.tag];
            [menuParent SetChecked: NO];
            ((CControlMenuItem*)menuParent).isUse = NO;
            
            //cho phep camera hoat dong tro lai
            [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:[CGlobalLayer GetLayer:@"mapground"] priority:0 swallowsTouches:NO];
            
            itemClicked = nil;
            
            return NO;
        }
        else
        {
            //nguoc lai neu nhan button khac thi button cu tro lai binh thuong
            if (itemClicked != nil)
            {
                id menuParent = [[CGlobalLayer GetLayer:@"mapmenu"] getChildByTag:[busmap.items indexOfObject: itemClicked]];
                [menuParent SetChecked: NO];
                ((CControlMenuItem*)menuParent).isUse = NO;
            }
        }
        
        [self SetChecked: YES];
        
        //item.color = ccc3(255, 123, 123);
        
        itemClicked = [NSNumber numberWithInt: itemIndex];
        
        return YES;
        
    }
    
    //xay dung station
    if (itemIndex == [itemClicked intValue] && itemClicked != nil && isClick == YES && [self isSwapMenu:touch] == YES)
    {
        NSLog(@"%@", [self CheckBuilt: p] ? @"yes" : @"no");
        
        int index, itemType;
        
        //neu vat pham drag vao ko phai la skill thi cho snap vao grid
        if (![[objectManager GetObject: itemIndex] isKindOfClass: [CInfoSkill class] ])
        {
            //snap vao grid
            index = [CGlobalMapGrid CoorToIndex: p];
            p = [CGlobalMapGrid IndexToCoor: index];
            //xet ve dang vat pham la station
            itemType = 1;
            busmap.estimatePoint = index;
        }
        
        if ([self CheckBuilt: p] || [[objectManager GetObject: itemIndex] isKindOfClass:[CInfoSkill class]])
        {
            //NSLog(@"click xay dung: %d, %d", itemIndex, [itemClicked intValue]);
            //bat dau thuc thi bus cua object
            [objectManager CreateObject:itemIndex coor: p delay:&delay];
            //xet delay cho item
            id action = [CGlobalActionDelayItem actionWithDuration:delay target: item ref:&isDelay];
            [self runAction: action];
        
            //remove mau sac
            id menuParent = [[CGlobalLayer GetLayer:@"mapmenu"] getChildByTag: [busmap.items indexOfObject: itemClicked]];
            [menuParent SetChecked: NO];       
            isClick = NO;
            isUse = NO;
            itemClicked = nil;
        }
    }
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{    
    if (isUse == NO)
        return;

    CGPoint pdrag = [touch locationInView: [touch view] ];
    pdrag = [[CCDirector sharedDirector] convertToGL: pdrag];
    CGPoint p = [busmap.camera2D.view convertTouchToNodeSpace:touch];
    point = p;
    
    if (isError == YES)
        return;
    
    if (itemIndex != [itemClicked intValue] && itemClicked != nil)
        return;
    
    //index -> dat tru , itemType -> 0: skill, 1: station
    int index, itemType = 0;
    
    //neu vat pham drag vao ko phai la skill thi cho snap vao grid
    if (![[objectManager GetObject: itemIndex] isKindOfClass: [CInfoSkill class] ])
    {
        //snap vao grid
        index = [CGlobalMapGrid CoorToIndex: p];
        p = [CGlobalMapGrid IndexToCoor: index];
        //xet ve dang vat pham la station
        itemType = 1;
        busmap.estimatePoint = index;
    }

    if (isDrag == YES)
    {
        //mau cua circle
        ccColor4B color;
        
        //neu la item keo tha vao la skill
        if (itemType == 0)
        {
            //mau xanh la cay
            color = ccc4(0, 255, 0, 0);
        }
        else
        {
            //nguoc lai la station
            //neu tai vi tri dat khong bi can tro thi mau xanh, nguoc lai la mau do
            if ([self IsHaveObject:index] == NO)
                color = ccc4(0, 255, 0, 0);
            else
                color = ccc4(255, 0, 0, 0);
        }
        
        //khoi tao circle khi drag
        //neu la skill thi itemobject = nil
        itemObject = [self GetSprite: itemIndex];       
        
        if (isDraw == NO && itemIndex == [itemClicked intValue])
        {
            //NSLog(@"test: %d - %@", itemIndex, itemClicked);
            //ve hinh tron theo radius cua object
            circle = [[ShapeCircle alloc] initWithColor:color radius:[self GetType: itemIndex].radius];
            [circle setPosition: p];
            [busmap.camera2D.layer addChild: circle];        
            
            //neu la station thi co them tile va character
            if (itemObject != nil)
            {
                rect = [CCSprite spriteWithFile: @"blank.jpg"];
                [rect setTextureRect: CGRectMake(0, 0, tileSize, tileSize)];
                [rect setColor:ccc3(color.r, color.g, color.b)];
                [rect setOpacity: 150];
                [rect setPosition:p];
                [busmap.camera2D.layer addChild: rect];
                
                itemObject = [self GetSprite: itemIndex];
                [itemObject setOpacity: 150];
                [itemObject setPosition: ccp(tileSize/2, tileSize/2)];
                [rect addChild: itemObject];
            }
            
            isDraw = YES;
        }
        else
        {
            [circle setPosition: p];
            [circle RefreshColor:color];
            
            [rect setPosition:p];
            [rect setColor:ccc3(color.r, color.g, color.b)];
        }
    }
    
    //neu diem keo tha khong nam trong item click
    if (!CGRectContainsPoint(_bounding, pdrag))
    {
        //keo tha
        isDrag = YES;
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    if (isUse == NO)
        return;
    
    isUse = NO;
    //cho phep keo tha camera
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:[CGlobalLayer GetLayer:@"mapground"] priority:0 swallowsTouches:NO];
    
    CGPoint p = [busmap.camera2D.view convertTouchToNodeSpace:touch];
    
    if (isError == YES)
    {
        isError = NO;
        return;
    }
    
    if (itemIndex != [itemClicked intValue] && itemClicked != nil)
        return;

    //click
    if (isDrag == NO)
        isClick = YES;
    
    //drag
    if (isDrag == YES)
    {
        //NSLog(@"drag");
        //NSLog(@"drag xay dung: %d", [itemClicked intValue]);
        
        //bat dau thuc thi bus cua object
        if ([self CheckBuilt: p] || [[objectManager GetObject: itemIndex] isKindOfClass:[CInfoSkill class]])
        {
            [objectManager CreateObject:itemIndex coor: p delay:&delay];
        
            //xet delay cho item
            if (delay != -1)
            {
                id action = [CGlobalActionDelayItem actionWithDuration:delay target: item ref:&isDelay];
                [self runAction: action];
            }
        }
        
        //remove mau sac
        id menuParent = [[CGlobalLayer GetLayer:@"mapmenu"] getChildByTag:[busmap.items indexOfObject: itemClicked]];
        [menuParent SetChecked: NO];
        itemClicked = nil;
        
        if (isDraw == YES)
        {
            [circle removeFromParentAndCleanup: YES];
            [rect removeFromParentAndCleanup: YES];
            isDraw = NO;
        }
    }
    
    //reset lai cac trang thai
    isDrag = NO;
    busmap.estimatePoint = -1;

}

-(void)dealloc
{
    //NSLog(@"dealling");
    itemClicked = nil;
    [super dealloc];
}

@end
