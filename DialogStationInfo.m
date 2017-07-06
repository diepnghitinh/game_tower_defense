//
//  DialogStationInfo.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DialogStationInfo.h"
#import "CBusiMap.h"
#import "CBusiStation.h"

@implementation DialogStationInfo

-(id)initWithItem:(int) _id point:(CGPoint)_point
{
    if (self=[super init])
    {
        id_ = _id;
        point_ = _point;
        [self Core];
    }
    return self;
}

- (void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-2 swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([super getChildByTag: 1] != nil)
        return YES;

    [self onExit];
    
    [[CGlobalLayer GetLayer:@"mapdialog"] removeChildByTag:1 cleanup:YES];
    
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    CBusiStation *station = [[busmap stations] objectForKey: [NSNumber numberWithInt: id_]];
    
    [station.body setColor:ccc3(255, 255, 255)];
   
    [self release];
    
    return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{}

- (void)Core
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    //lay level cua station
    CBusiStation *station = [[busmap stations] objectForKey: [NSNumber numberWithInt: id_]];
    [station.body setColor:ccc3(255, 123, 123)];
    
    if (iPad)
        bg = [CCSprite spriteWithFile:@"ipad-dialog-info.png"];
    else
        bg = [CCSprite spriteWithFile:@"iphone-dialog-info.png"];
    [self setPosition:ccp(-screenSize.width/2, -screenSize.height/2)];
    [self addChild: bg];

    CCSprite *sprite1 = [CCSprite spriteWithFile:@"universal-icon-update.png" rect:CGRectMake(0, 0, 50, 50)];
    CCSprite *sprite2 = [CCSprite spriteWithFile:@"universal-icon-update.png" rect:CGRectMake(0, 0, 50, 50)];
    
    CCMenuItemSprite *update = [CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:sprite2 target:self selector:@selector(Update:)];
    
    sprite1 = [CCSprite spriteWithFile:@"universal-icon-update.png" rect:CGRectMake(0, 50, 50, 50)];
    sprite2 = [CCSprite spriteWithFile:@"universal-icon-update.png" rect:CGRectMake(0, 50, 50, 50)];
    CCMenuItemSprite *sell = [CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:sprite2 target:self selector:@selector(Sell:)];
    
    CCMenu *menu = [CCMenu menuWithItems: update, sell, nil];
    [menu alignItemsVertically];
    [menu alignItemsVerticallyWithPadding: 10];
    [menu setPosition: ccp(bg.contentSize.width/2, bg.contentSize.height/2)];
    
    CCLabelTTF* label =  [CCLabelTTF labelWithString:[NSString stringWithFormat: @"Lv %d" , station.info.level] fontName:@"Arial" fontSize:25];
    [label setPosition:ccp(bg.contentSize.width/2, bg.contentSize.height + 15)];
    
    [bg addChild: label];
    [bg addChild: menu];
    
    float y;
    
    if (point_.y - bg.contentSize.height/2 < 0)
        y = point_.y + bg.contentSize.height/2;
    else if (point_.y + bg.contentSize.height/2 > screenSize.height)
        y = point_.y - bg.contentSize.height/2;
    else
        y = point_.y;
    
    
    if (point_.x > screenSize.width/2)
        [bg setPosition: ccp(point_.x - bg.contentSize.width/2, y)];
    else
        [bg setPosition: ccp(point_.x + bg.contentSize.width/2, y)];
}

-(void)Sell:(id)sender
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    //remove khoi mang station
    [busmap removeStation: [NSNumber numberWithInt: id_]];
    [self Cancel: sender];
}

-(void)Update:(id)sender
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    CBusiStation *station = [[busmap stations] objectForKey: [NSNumber numberWithInt: id_]];
    
    if (busmap.mapinfo.cost - station.info.cost >= 0)
    {
        busmap.mapinfo.cost -= station.info.cost;
        [busmap UpdateCost];
        [station UpLevel];
    }
    
    [self Cancel: sender];
}

-(void)Cancel:(id)sender
{    
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    CBusiStation *station = [[busmap stations] objectForKey: [NSNumber numberWithInt: id_]];
    
    [station.body setColor:ccc3(255, 255, 255)];
    
    [[CGlobalLayer GetLayer:@"mapdialog"] removeChildByTag:1 cleanup:YES];
    [self release];
}

@end
