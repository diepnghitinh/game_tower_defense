//
//  CGlobalActionMapResult.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalEffectMapResult.h"
#import "CGlobalLayer.h"
#import "CDataDatabase.h"
#import "CBusiMap.h"
#import "CGlobalVariables.h"
#import "SceneMap.h"
#import "SceneMain.h"
#import "Emty.h"

@implementation CGlobalEffectMapResult

+(id) actionWithMethod:(int)result
{
	return [[[self alloc] initWithMethod:result] autorelease];
}

-(id) initWithMethod:(int)result
{
	if( (self=[super init]) ) {
        
        youwin = [CCSprite spriteWithFile: @"youwin.png"];
        youlose = [CCSprite spriteWithFile: @"youlose.png"];
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        //pause man hinh lai
        ccColor4B c = {0,0,0,150};
        layer_ = [CGlobalLayer layerWithColor:c delegate: [CGlobalLayer GetLayer:@"mapdialog"]];
        
        //hien thi chu "you win"
        if (result == 0)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"win.mp3"];
            
            [youwin setPosition: ccp(screenSize.width/2, screenSize.height/2)];
            [youwin setOpacity: 0];
        
            id action = [CCSequence actions: [CCFadeIn actionWithDuration: 1] , [CCDelayTime actionWithDuration: 2], [CCFadeOut actionWithDuration: 1], [CCCallFunc actionWithTarget:self selector:@selector(Win)], nil];
        
            [youwin runAction: action];
            [layer_ addChild: youwin z: 2];
        } else
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"lose.mp3"];
            
            [youlose setPosition: ccp(screenSize.width/2, screenSize.height/2)];
            [youlose setOpacity: 0];
            
            id action = [CCSequence actions: [CCFadeIn actionWithDuration: 1] , [CCDelayTime actionWithDuration: 2], [CCFadeOut actionWithDuration: 1], [CCCallFunc actionWithTarget:self selector:@selector(Lose)], nil];
            
            [youlose runAction: action];
            [layer_ addChild: youlose z: 2];
        }
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
	}
	return self;
}

-(void)Win
{
    
    //unlock map moi
    CDataDatabase *connect = [[[CDataDatabase alloc] init] autorelease];
    
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];

    nextMap = busmap.mapid;
    nextMap++;
    
    int val = [[connect GetKey: @"currentmap"] intValue];
    
    if ([[connect GetKey: @"currentmap"] intValue] < ([[connect GetKey:@"totalmap"] intValue] - 1))
    {
        if (val < nextMap)
        {
            [connect UpdateKey:@"currentmap" val: [NSNumber numberWithInt: nextMap]];
        } 
    }
    
    if (nextMap-1 == [[connect GetKey:@"totalmap"] intValue] - 1)
    {
        [self Lose];
        return;
    }
    
    //ve ra menu chon lua
    CGSize screenSize = [CCDirector sharedDirector].winSize;

    CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage: @"universal-next.png" selectedImage:@"universal-next.png" block:^(id sender)
                                  {   
                                      //set lai next map
                                      [CGlobalVariables SetMapPlay: [[CBusiMap node] initWithMap: nextMap]];
                                      
                                      //replace scene hien tai
                                      [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMap scene] ]];
                                  }];
    
    //replay lai van dau
    CCMenuItemImage *menuItem2 = [CCMenuItemImage itemFromNormalImage: @"universal-truyagain.png" selectedImage:@"universal-truyagain.png" block:^(id sender)
                                  {
                                      [[CGlobalLayer GetLayer: @"mapmain"] release];
                                      
                                      [[CGlobalLayer GetLayer: @"mapmain"] clear];                                      
                                      
                                      //giai phong bo nho cbus
                                      CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
                                      
                                      [CGlobalVariables SetMapPlay: [[CBusiMap node] initWithMap: busmap.mapid]];
                                      //replace scene hien tai
                                      [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMap scene] ]];
                                  }];
    
    //tro ve man hinh chinh
    CCMenuItemImage *menuItem3 = [CCMenuItemImage itemFromNormalImage: @"universal-back.png" selectedImage:@"universal-back.png" block:^(id sender)
                                  {
                                      [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMain scene] ]];
                                  }];
    
    CCMenu *menu1 = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
    [menu1 alignItemsHorizontally];
    [menu1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    
    
    CCMenuItemImage *menuItem4 = [CCMenuItemImage itemFromNormalImage: @"universal-close.png" selectedImage:@"universal-close-hover.png" block:^(id sender)
                                  {
                                      [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMain scene] ]];
                                  }];
    CCMenu *menu2 = [CCMenu menuWithItems:menuItem4, nil];
    [menu2 alignItemsHorizontally];
    [menu2 setPosition:ccp(screenSize.width/2 + 125, screenSize.height/2 + 58)];
    

    CCSprite *dialog = [CCSprite spriteWithFile: @"universal-dialog.png"];
    [dialog setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [layer_ addChild: dialog];
    
    [layer_ addChild: menu1];
    [layer_ addChild: menu2];
    
}

-(void)Lose
{
    //ve ra menu chon lua
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    //replay lai van dau
    CCMenuItemImage *menuItem1 = [CCMenuItemImage itemFromNormalImage: @"universal-truyagain.png" selectedImage:@"universal-truyagain.png" block:^(id sender)
                                  {               
                                      //giai phong bo nho cbus
                                      CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
                                      
                                      [CGlobalVariables SetMapPlay: [[CBusiMap node] initWithMap: busmap.mapid]];
                                      
                                      //replace scene hien tai
                                      [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMap scene] ]];
                                  }];
    
    //tro ve man hinh chinh
    CCMenuItemImage *menuItem2 = [CCMenuItemImage itemFromNormalImage: @"universal-back.png" selectedImage:@"universal-back.png" block:^(id sender)
                                  {
                                      [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMain scene] ]];
                                  }];
    
    CCMenu *menu1 = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
    [menu1 alignItemsHorizontally];
    [menu1 alignItemsHorizontallyWithPadding: 15.0f];
    [menu1 setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    
    
    CCMenuItemImage *menuItem4 = [CCMenuItemImage itemFromNormalImage: @"universal-close.png" selectedImage:@"universal-close-hover.png" block:^(id sender)
                                  {
                                      [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMain scene] ]];
                                  }];
    CCMenu *menu2 = [CCMenu menuWithItems:menuItem4, nil];
    [menu2 alignItemsHorizontally];
    [menu2 setPosition:ccp(screenSize.width/2 + 125, screenSize.height/2 + 58)];
    
    CCSprite *dialog = [CCSprite spriteWithFile: @"universal-dialog.png"];
    [dialog setPosition:ccp(screenSize.width/2, screenSize.height/2)];
    [layer_ addChild: dialog];
    
    [layer_ addChild: menu1];
    [layer_ addChild: menu2];
}

-(void)dealloc
{
    NSLog(@"result remove");
    [super dealloc];
}

@end
