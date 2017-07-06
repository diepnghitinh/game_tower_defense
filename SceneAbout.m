//
//  SceneAbout.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneAbout.h"
#import "SceneMain.h"
#import "CGlobalSprite.h"

@implementation SceneAbout

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SceneAbout *layer = [SceneAbout node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        if (iPad)
            [self IpadDraw];
        else
            [self IphoneDraw];
        
	}
	return self;
}

-(void)IpadDraw
{
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    bg = [CCSprite spriteWithFile: @"ipad-userguide.png"];
    [bg setAnchorPoint: ccp(0, 0)];
    [self addChild: bg];
    
    
    //item exit
    sprite1 = [CCSprite spriteWithFile:@"ipad-play-pause.png" rect:CGRectMake(96, 0, 48, 48)];
    sprite2 = [CCSprite spriteWithFile:@"ipad-play-pause.png" rect:CGRectMake(96, 0, 48, 48)];
    
    exit = [CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:sprite2 block:^(id sender)
            {
                //replace scene hien tai
                [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMain scene] ]];
            }];
    
    CCMenu *menu = [CCMenu menuWithItems:exit, nil];
    [menu setPosition: ccp(screenSize.width-60, 50)];
    [self addChild: menu];
}

-(void)IphoneDraw
{
    
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    bg = [[CCSprite spriteWithFile: @"iphone-userguide.png"] retain];
    [bg setAnchorPoint: ccp(0, 0)];
    [self addChild: bg];
    
    
    //item exit
    sprite1 = [CCSprite spriteWithFile:@"iphone-play-pause.png" rect:CGRectMake(66, 0, 33, 33)];
    sprite2 = [CCSprite spriteWithFile:@"iphone-play-pause.png" rect:CGRectMake(66, 0, 33, 33)];
    
    exit = [CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:sprite2 block:^(id sender)
            {
                //replace scene hien tai
                [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMain scene] ]];
            }];
    
    CCMenu *menu = [CCMenu menuWithItems:exit, nil];
    [menu setPosition: ccp(screenSize.width-40, 25)];
    [self addChild: menu];
}

-(void)dealloc
{
    //remove sprite
    [CGlobalSprite RemoveSprite: bg];
    
    //cac nut menu
    [[CCTextureCache sharedTextureCache] removeTexture: sprite1.texture];
    [sprite1 removeFromParentAndCleanup: YES];
    
    [[CCTextureCache sharedTextureCache] removeTexture: sprite2.texture];
    [sprite2 removeFromParentAndCleanup: YES];
    
    [super dealloc];
}

@end
