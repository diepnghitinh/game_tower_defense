//
//  ScenePickItem.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScenePickItem.h"
#import "CBusiMap.h"
#import "SceneMapMenu.h"
#import "CGlobalSprite.h"
#import "SceneMap.h"

@implementation ScenePickItem

-(id) init
{
	if( (self=[super init] )) {

        LayerBackground = [SceneLayerBackground node];
        //stack index
        itemsChose = [[NSMutableDictionary alloc] init];
        itemsChoseList = [[NSMutableDictionary alloc] init];
        itemsChoseSprite = [[NSMutableDictionary alloc] init];
        itemsUseList = [[NSMutableDictionary alloc] init];

        [self addChild:LayerBackground];
        
        if (iPad)
            [self DrawContentIpad];
        else
            [self DrawContentIphone];

        [self FirstLoad];
	}
	return self;
}

-(void)DrawContentIpad
{
    
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    //them background vao screen
    background = [CCSprite spriteWithFile: @"ipad-pickitem-bg.png"];
    [background setPosition: ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild: background];
    
    //button apply
    next = [CCMenuItemImage itemFromNormalImage:@"ipad-pickitem-next.png" selectedImage:@"ipad-pickitem-next.png" target:self selector:@selector(PlayGame:)];
    
    CCMenu *menu = [CCMenu menuWithItems:next, nil];
    [menu setPosition:ccp(screenSize.width/2, 150)];
    menu.visible = NO;
    //tag 7 : mac dinh an di nut vao game
    [self addChild:menu z:1 tag:7];
    
    // tong so item tren 1 trang, tong so trang hien co
    int item_per_page, number_of_page;
    
    item_per_page = 7;
    
    unlockItem = busmap.mapinfo.itemUnlock;
    
    number_of_page = ceil ( (float)unlockItem  / item_per_page );
    
    NSMutableArray *pageitem = [NSMutableArray array];
    
    //them scene item vao mang
    int j = 0;
    
    for (int i = 0; i < number_of_page; ++i)
    {
        
        CCLayer *layer = [[CCLayer alloc] init];
        
        float _position = 75;
        int nitem = 1;
        
        while(j < unlockItem)
        {
            //danh dau mang toa do o items su dung
            [itemsChose setObject: [NSArray arrayWithObjects: [NSNumber numberWithFloat: _position], [NSNumber numberWithFloat: screenSize.height/2 + 100], nil ] forKey:[NSNumber numberWithInt:j]];
            
            CCMenuItem *item = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"ipad-card-%d.png", j] selectedImage:[NSString stringWithFormat:@"ipad-card-%d.png", j] target:self selector:@selector(PickItem:)];
            
            //xet toa do cho item chon
            id op = [itemsChose objectForKey: [NSNumber numberWithInt:j]];
            [item setPosition: ccp([[op objectAtIndex: 0] floatValue], [[op objectAtIndex: 1] floatValue])];
            [item setTag: j];
            
            CCMenu *menu = [CCMenu menuWithItems:item, nil];
            [menu setPosition: ccp(0,0)];
            [layer addChild: menu];
            //them vao danh sach menu list, co gi 1 lat disable no
            [itemsChoseList setObject:menu forKey:[NSNumber numberWithInt:j]];
            _position += 145;
            
            ++j;
            if (++nitem > item_per_page)
                break;
        }
        
        [pageitem addObject: layer];
        [layer release];
    }
    
    float _position = 75;
    for (int i = 0; i < 7; ++i)
    {
        sprite = [CCSprite spriteWithFile:@"ipad-card-item.png" rect:CGRectMake(0, 0, 115, 112)];
        [sprite setPosition: ccp(_position, screenSize.height/2 - 80)];
        //danh dau mang toa do o items su dung
        itemsPoint[i] = ccp(sprite.position.x, sprite.position.y);
        
        [self addChild: sprite];
        _position += 145;
    }
    
    // khoi tao scroll layer
    CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:pageitem widthOffset: 0];
    scroller.pagesIndicatorPosition = ccp( screenSize.width/2 , screenSize.height/2 + 10);
    [scroller setMinimumTouchLengthToChangePage: 50.0f];
    
    // cuoi cung them no vao self
    [self addChild:scroller];
    
}

-(void)DrawContentIphone
{
    
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
     //them background vao screen
    background = [CCSprite spriteWithFile: @"iphone-pickitem-bg.png"];
    [background setPosition: ccp(screenSize.width/2, screenSize.height/2)];
    [self addChild: background];
    
    //button apply
    next = [CCMenuItemImage itemFromNormalImage:@"iphone-pickitem-next.png" selectedImage:@"iphone-pickitem-next.png" target:self selector:@selector(PlayGame:)];
    
    CCMenu *menu = [CCMenu menuWithItems:next, nil];
    [menu setPosition:ccp( screenSize.width/2 +10  , screenSize.height/2 - 100)];
    menu.visible = NO;
    //tag 7 : mac dinh an di nut vao game
    [self addChild:menu z:1 tag:7];
    
    // tong so item tren 1 trang, tong so trang hien co
    int item_per_page, number_of_page;
    
    item_per_page = 7;
    
    unlockItem = busmap.mapinfo.itemUnlock;
    
    number_of_page = ceil ( (float)unlockItem  / item_per_page );
    
    NSMutableArray *pageitem = [NSMutableArray array];
    
    //them scene item vao mang
    int j = 0;
    
    for (int i = 0; i < number_of_page; ++i)
    {
        
        CCLayer *layer = [[CCLayer alloc] init];
        
        float _position = 40;
        int nitem = 1;
        
        while(j < unlockItem)
        {
            //danh dau mang toa do o items su dung
            [itemsChose setObject: [NSArray arrayWithObjects: [NSNumber numberWithFloat: _position], [NSNumber numberWithFloat: screenSize.height/2 + 50], nil ] forKey:[NSNumber numberWithInt:j]];
            
            CCMenuItem *item = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"iphone-card-%d.png", j] selectedImage:[NSString stringWithFormat:@"iphone-card-%d.png", j] target:self selector:@selector(PickItem:)];
            
            //xet toa do cho item chon
            id op = [itemsChose objectForKey: [NSNumber numberWithInt:j]];
            [item setPosition: ccp([[op objectAtIndex: 0] floatValue], [[op objectAtIndex: 1] floatValue])];
            [item setTag: j];
            
            CCMenu *menu = [CCMenu menuWithItems:item, nil];
            [menu setPosition: ccp(0,0)];
            [layer addChild: menu];
            //them vao danh sach menu list, co gi 1 lat disable no
            [itemsChoseList setObject:menu forKey:[NSNumber numberWithInt:j]];
            _position += 67;
            
            ++j;
            if (++nitem > item_per_page)
                break;
        }
        
        [pageitem addObject: layer];
        [layer release];
    }
    
    float _position = 40;
    for (int i = 0; i < 7; ++i)
    {
        sprite = [CCSprite spriteWithFile:@"iphone-card-item.png" rect:CGRectMake(0, 0, 57, 55)];
        [sprite setPosition: ccp(_position, screenSize.height/2-30)];
        //danh dau mang toa do o items su dung
        itemsPoint[i] = ccp(sprite.position.x, sprite.position.y);
        
        [self addChild: sprite];
        _position += 67;
    }
    
    // khoi tao scroll layer
    CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:pageitem widthOffset: 0];
    scroller.pagesIndicatorPosition = ccp( screenSize.width/2 , screenSize.height/2 + 10);
    
    [scroller setMinimumTouchLengthToChangePage: 50.0f];
    
    // cuoi cung them no vao self
    [self addChild:scroller];
    
}

-(void)PauseLayer
{
    [[CGlobalLayer GetLayer:@"mapground"] Pause];
    [[CGlobalLayer GetLayer:@"mapmenu"] Pause];
}

-(void)ResumeLayer
{
    [[CGlobalLayer GetLayer:@"mapground"] unPause];
    [[CGlobalLayer GetLayer:@"mapmenu"] unPause];
    //remove layer hien tai
    [self removeAllChildrenWithCleanup:YES];
    [self removeFromParentAndCleanup: YES];
    NSLog(@"remove");
}

-(void)PickItem:(id)sender
{
    int index = [sender tag];
    
    //tang statck len 1 neu tai vi tri ke tiep trong
    itemsIndex = 0;
    while ([itemsUseList objectForKey:[NSNumber numberWithInt:itemsIndex]] != nil)
    {
        ++itemsIndex;
    }
    
    //neu full thi ko cho them vao nua
    if ([itemsUseList count] > 6)
    {
        return;
    }
    
    //tao 1 sprite cua item chon
    CCSprite *osprite;
    if (iPad)
        osprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ipad-card-%d.png", index] rect:CGRectMake(0, 0, 112, 115)];
    else
        osprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"iphone-card-%d.png", index] rect:CGRectMake(0, 0, 57, 55)];
    [osprite setOpacity:128];
    
    //hien thi no tai diem hien tai
    id op = [itemsChose objectForKey: [NSNumber numberWithInt:index]];
    [osprite setPosition: ccp([[op objectAtIndex: 0] floatValue], [[op objectAtIndex: 1] floatValue])];
    [self addChild:osprite z: 1];
    
    //dua vao sprite memory, de ko bi xung dot sprite
    [itemsChoseSprite setObject:osprite forKey:[NSNumber numberWithInt:index]];
    
    //tao 1 package de truyen xuong use list item
    NSMutableDictionary *package = [[NSMutableDictionary alloc] init];
    [package setObject:[NSNumber numberWithInt:index] forKey:@"indexChose"];
    [package setObject:[NSNumber numberWithInt:itemsIndex] forKey:@"indexUse"];
    [package setObject:osprite forKey:@"sprite"];
    
    //them vao use list
    [itemsUseList setObject:[package objectForKey:@"indexChose"] forKey:[package objectForKey:@"indexUse"]];
    
    if ([itemsUseList count] > 6)
    {
        //hien thi nut next
        [self getChildByTag:7].visible = YES;
    }
    //danh dau da dua chose list vao use list
    CCMenu *o1 = [itemsChoseList objectForKey: [package objectForKey:@"indexChose"]];
    [o1 setColor: ccc3(79, 79, 79)];
    [o1 setIsTouchEnabled: NO];
    
    //action move den o item su dung
    id action = [CCMoveTo actionWithDuration:0.5 position:itemsPoint[itemsIndex]];
    action = [CCEaseSineOut actionWithAction: action];
    action = [CCSequence actions:action, [CCCallFuncO actionWithTarget:self selector:@selector(DisplayOpacity:) object:package] , nil];
    [osprite runAction: action];
}

-(void)RemoveUseItem:(id)key
{
    int useindex = [key tag];
    int choseindex = [[itemsUseList objectForKey:[NSNumber numberWithInt:useindex]] intValue];
    
    [self getChildByTag:7].visible = NO;
    [self removeChildByTag:useindex cleanup:YES];
    [itemsUseList removeObjectForKey: [NSNumber numberWithInt:useindex]];
    
    CCMenu *chosebutton = [itemsChoseList objectForKey: [NSNumber numberWithInt:choseindex] ];
    [chosebutton setColor: ccc3(255, 255, 255)];
    [chosebutton setIsTouchEnabled: YES];
}

//dinh dang va bien no thanh cai nut
-(void)DisplayOpacity:(id)key
{
    
    NSMutableDictionary *package = key;
    
    //tao 1 button cho use list
    CCSprite* button = [package objectForKey:@"sprite"];
    
    CCSprite* button1 = [CCSprite spriteWithTexture: button.texture];
    CCSprite* button2 = [CCSprite spriteWithTexture: button.texture];
    
    [button setOpacity: 255];
    //xoa sprite
    [button removeFromParentAndCleanup: YES];
    
    //bien no thanh cai nut
    //sau do add vao use list
    CCMenuItemSprite *item = [CCMenuItemSprite itemFromNormalSprite:button1 selectedSprite:button2 target:self selector:@selector(RemoveUseItem:)];
    [item setTag: [[package objectForKey:@"indexUse"] intValue] ];
    CCMenu *menu = [CCMenu menuWithItems:item, nil];
    [menu setPosition: button.position ];
    [self addChild:menu z:0 tag: [[package objectForKey:@"indexUse"] intValue]];
    
}

-(void)PlayGame:(id)sender
{
    [self ResumeLayer];

    //lay dc items va add vao ban do
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [itemsUseList count]; ++i)
    {
        [array addObject:[itemsUseList objectForKey: [NSNumber numberWithInt: i]]];
    }
    busmap.items = array;
    
    NSLog(@"play game: %@", [CGlobalLayer GetLayer:@"mapmenu"]);
    
    //ve menu vao layer map menu
    [[CGlobalLayer GetLayer:@"mapmenu"] CoreMenu];
    //play nhac nen
    [[CGlobalLayer GetLayer:@"mapground"] PlayBackground];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 0.4f];
}

-(void)FirstLoad
{
    [self PauseLayer];
    
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    //kiem tra xem xem item unlock duoi 6 thi bat dau game luon
    if (busmap.mapinfo.itemUnlock <= 7)
    {
        
        [self ResumeLayer];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < 7; ++i)
        {
            [array addObject:[NSNumber numberWithInt: i]];
        }
        busmap.items = array;
        //ve menu vao layer map menu
        [[CGlobalLayer GetLayer:@"mapmenu"] CoreMenu];
        //play nhac nen
        [[CGlobalLayer GetLayer:@"mapground"] PlayBackground];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 0.4f];
    }
}

-(void)dealloc
{
    NSLog(@"item dealloc");
    [super dealloc];
}

@end
