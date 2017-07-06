//
//  SceneMapMenuVertical.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneMapMenu.h"
#import "CBusiMap.h"
#import "CControlMenuItem.h"
#import "ScenePickMap.h"

@implementation SceneMapMenu

@synthesize menu;

-(id) init
{
	if( (self=[super init] ))
    {
        if (iPad)
            [self DrawContentIpad];
        else
            [self DrawContentIphone];

	}
	return self;
}

- (void) onEnter
{
    if(!isPause && !isTouch)
    {
        isTouch = YES;
        [super onEnter];
    }
}

- (void) onExit
{
    if(!isPause)
    {
        [super onExit];
    }
    isPause = NO;
    isTouch = NO;
}

- (void) Pause
{
    if(isPause)
    {
        return;
    }
    
    [self onExit];
    isPause = YES;
}

- (void) unPause
{
    if(!isPause)
    {
        return;
    }
    isPause = NO;
    [self onEnter];
}

-(void)UpdateWave
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    [round setString:[NSString stringWithFormat:@"Round %d-%d", busmap.mapinfo.wave,[busmap.mapinfo.enemys count]]];
};

-(void)UpdateCost
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    [money setString: [NSString stringWithFormat:@"%d", busmap.mapinfo.cost]];
};

-(void)UpdateHealth
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    [house setString: [NSString stringWithFormat:@"%d", busmap.mapinfo.health]];
};

-(void)DrawContentIpad
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];    
    
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //ve thong tin o top
    spriteHouse = [CCSprite spriteWithFile:@"ipad-icon-house.png"];
    [spriteHouse setPosition:ccp(screenSize.width - 50, screenSize.height - 50)];
    [self addChild: spriteHouse z:2];
    spriteMoney = [CCSprite spriteWithFile:@"ipad-icon-money.png"];
    [spriteMoney setPosition:ccp(screenSize.width - 200, screenSize.height - 50)];
    [self addChild: spriteMoney z:2];
    
    //ve cac thong tin
    round = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Round 0-%d", [busmap.mapinfo.enemys count]] fontName:@"Courier" fontSize:40];
    [round setPosition:ccp(screenSize.width / 2, screenSize.height - 50)];
    [self addChild: round z:2];
    
    money = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", busmap.mapinfo.cost] fontName:@"Courier" fontSize:40];
    [money setPosition:ccp(screenSize.width - 270, screenSize.height - 50)];
    [self addChild: money z:2];
    
    house = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", busmap.mapinfo.health] fontName:@"Courier" fontSize:40];
    [house setPosition:ccp(screenSize.width - 120, screenSize.height - 50)];
    [self addChild: house z:2];
    
    //tao button pause
    CCSprite *sprite1 = [CCSprite spriteWithFile:@"ipad-play-pause.png" rect:CGRectMake(0, 0, 48, 48)];
    CCSprite *sprite2 = [CCSprite spriteWithFile:@"ipad-play-pause.png" rect:CGRectMake(0, 0, 48, 48)];
 
    CCMenuItemSprite *pauseplay = [CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:sprite2 target:self selector:@selector(pauseLayer)];
    
    menu = [CCMenu menuWithItems: pauseplay, nil];
    [menu alignItemsHorizontallyWithPadding: 20];
    
    [menu setPosition: ccp(screenSize.width - 50, 50)];
    
    [self addChild: menu z:2];
}

-(void)DrawContentIphone
{
    //tao button pause
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];    
    
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //ve thong tin o top
    spriteHouse = [CCSprite spriteWithFile:@"iphone-icon-house.png"];
    [spriteHouse setPosition:ccp(screenSize.width - 30, screenSize.height - 20)];
    [self addChild: spriteHouse z:2];
    spriteMoney = [CCSprite spriteWithFile:@"iphone-icon-money.png"];
    [spriteMoney setPosition:ccp(screenSize.width - 100, screenSize.height - 20)];
    [self addChild: spriteMoney z:2];
    
    //ve cac thong tin
    round = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Round 0-%d", [busmap.mapinfo.enemys count]] fontName:@"Courier" fontSize:20];
    [round setPosition:ccp(screenSize.width / 2, screenSize.height - 20)];
    [self addChild: round z:2];
    
    money = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", busmap.mapinfo.cost] fontName:@"Courier" fontSize:20];
    [money setPosition:ccp(screenSize.width - 135, screenSize.height - 20)];
    [self addChild: money z:2];
    
    house = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", busmap.mapinfo.health] fontName:@"Courier" fontSize:20];
    [house setPosition:ccp(screenSize.width - 65, screenSize.height - 20)];
    [self addChild: house z:2];
    
    //tao button pause
    CCSprite *sprite1 = [CCSprite spriteWithFile:@"iphone-play-pause.png" rect:CGRectMake(0, 0, 33, 33)];
    CCSprite *sprite2 = [CCSprite spriteWithFile:@"iphone-play-pause.png" rect:CGRectMake(0, 0, 33, 33)];
    
    CCMenuItemSprite *pauseplay = [CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:sprite2 target:self selector:@selector(pauseLayer)];
    
    menu = [CCMenu menuWithItems: pauseplay, nil];
    [menu alignItemsHorizontallyWithPadding: 20];
    
    [menu setPosition: ccp(screenSize.width - 30, 25)];
    
    [self addChild: menu z:2];
}

-(void)pauseLayer
{
    //pause nhac nen
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    ccColor4B c ={0,0,0,150};
    [CGlobalLayer layerWithColor:c delegate: [CGlobalLayer GetLayer:@"mapdialog"] selector:@selector(resumeLayer)];
    //an menu di
    [menu setVisible:NO];
}

-(void)CoreMenuIpad
{
    //ve danh sach menu item ra
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    float _postion = [CCDirector sharedDirector].winSize.height - 65;
    for (int i = 0; i < [busmap.items count]; ++i)
    {
        CControlMenuItem *item = [[CControlMenuItem alloc] initWithItem:[[busmap.items objectAtIndex:i] intValue]];
        [item setPosition:ccp(60, _postion)];
        //dat tag de quan ly
        [self addChild: item z:0 tag: i];
        [item SetBounding];
        _postion -= 105;
    }
}

-(void)CoreMenuIphone
{
    
    NSLog(@"core menu");
    
    //ve danh sach menu item ra
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    float _postion = [CCDirector sharedDirector].winSize.height - 25;
    for (int i = 0; i < [busmap.items count]; ++i)
    {
        CControlMenuItem *item = [[[CControlMenuItem alloc] initWithItem:[[busmap.items objectAtIndex:i] intValue]] autorelease];
        [item setPosition:ccp(30, _postion)];
        //dat tag de quan ly
        [self addChild: item z:0 tag: i];
        [item SetBounding];
        _postion -= 45;
    }
}

-(void)CoreMenu
{
    if (iPad)
        [self CoreMenuIpad];
    else
        [self CoreMenuIphone];
}

- (void) dealloc
{
    [CGlobalSprite RemoveSprite: spriteHouse];
    [CGlobalSprite RemoveSprite: spriteMoney];
	[super dealloc];
}

@end
