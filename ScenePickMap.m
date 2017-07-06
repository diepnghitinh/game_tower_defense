//
//  ScenePickMap.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScenePickMap.h"
#import "SceneMain.h"
#import "CGlobalSprite.h"
#import "CGlobalLayer.h"

@implementation ScenePickMap

+(CCScene *) scene
{
    
    NSLog(@"PICKMAP SCENE");
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ScenePickMap *layer = [ScenePickMap node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init] )) {
        if (iPad)
            [self DrawContentIpad];
        else
            [self DrawContentIphone];
        
        //load am thanh nen
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgm-2.mp3" loop:YES];
	}
	return self;
}

-(void) DrawContentIpad
{
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    int map_per_page, number_of_page;
    NSNumber *num_map, *unlockmap;
    //ket noi csdl
    CDataDatabase *database = [[[CDataDatabase alloc] init] autorelease];
    
    map_per_page = 2;
    num_map = [NSNumber numberWithInt:[[database GetKey:@"totalmap"] intValue]];
    number_of_page = ceil ( [num_map floatValue]  / map_per_page );
    unlockmap = [NSNumber numberWithInt:[[database GetKey:@"currentmap"] intValue]];
    
    background = [CCSprite spriteWithFile: @"ipad-pickmap-bg.png"];
    [background setAnchorPoint: ccp(0, 0)];    
    [self addChild: background];
    
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
    
    NSMutableArray *pagescene = [NSMutableArray array];
    //them scene page vao mang
    int j = 0;
    
    for (int i=0;i<number_of_page;++i)
    {
        CCLayer *layer = [[CCLayer alloc] init];
        
        int sort = 1, postion = screenSize.width / 2 - 200;
        
        while(j < [num_map intValue])
        {
            
            CCMenuItemFont *label = [CCMenuItemFont itemFromString:[NSString stringWithFormat:@"map: %d",j] target:self selector: @selector(GoToMap:)];
            [label setFontSize: 15];
            [label setFontName: @"Marker Felt"];
            [label setTag:j];
            
            if (sort%3 == 0)
                [label setPosition:ccp(screenSize.width/2 + 160, screenSize.height/2)]; // 3
            else if (sort%2 == 0)
                [label setPosition:ccp(screenSize.width/2, screenSize.height/2)]; // 2
            else
                [label setPosition:ccp(screenSize.width/2 - 160, screenSize.height/2)]; // 1
            
            CCMenu *menu = [CCMenu menuWithItems:label, nil];
            [menu setPosition:ccp(0, 0)];
            
            //hinh anh
            BOOL isClick = NO;
            CCSprite *avatar;
            CCMenuItemImage *map;
            
            if (j > [unlockmap intValue])
                avatar = [CCSprite spriteWithFile: @"ipad-pickmap-lock.png"];
            else
            {
                map = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat: @"ipad-pickmap-%d.png", j] selectedImage:[NSString stringWithFormat: @"ipad-pickmap-%d.png", j] target:self selector:@selector(GoToMap:)];
                [map setTag:j];
                isClick = YES;
            }
            
            if (isClick)
            {
                CCMenu *menu = [CCMenu menuWithItems: map, nil];
                [menu setPosition: ccp(postion-5,screenSize.height/2)];
                [layer addChild: menu];
            }
            else
            {
                [avatar setPosition: ccp(postion-5,screenSize.height/2)];
                [layer addChild: avatar];
            }
            
            CCSprite *frame = [CCSprite spriteWithFile: @"ipad-pickmap-frame.png"];
            [frame setPosition: ccp(postion,screenSize.height/2)];
            [layer addChild:frame];
            
            
            ++j;
            if (++sort > map_per_page)
            {
                break;
            }
            postion += 400;
        }
        
        [pagescene addObject: layer];
        [layer release];
    }
    
    // khoi tao scroll layer
    CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:pagescene widthOffset: 0];
    [scroller setMinimumTouchLengthToChangePage: 50.0f];
    
    // cuoi cung them no vao self
    [self addChild:scroller];
    
}

-(void) DrawContentIphone
{
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    int map_per_page, number_of_page;
    NSNumber *num_map, *unlockmap;
    //ket noi csdl
    CDataDatabase *database = [[[CDataDatabase alloc] init] autorelease];
    
    map_per_page = 2;
    num_map = [NSNumber numberWithInt:[[database GetKey:@"totalmap"] intValue]];
    number_of_page = ceil ( [num_map floatValue]  / map_per_page );
    unlockmap = [NSNumber numberWithInt:[[database GetKey:@"currentmap"] intValue]];
    
    background = [CCSprite spriteWithFile: @"iphone-pickmap-bg.png"];
    [background setAnchorPoint: ccp(0, 0)];    
    [self addChild: background];
    
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
    
    NSMutableArray *pagescene = [NSMutableArray array];
    //them scene page vao mang
    int j = 0;
    
    for (int i=0;i<number_of_page;++i)
    {
        CCLayer *layer = [[CCLayer alloc] init];
        
        int sort = 1, postion = screenSize.width / 2 - 120;
        
        while(j < [num_map intValue])
        {
            
            CCMenuItemFont *label = [CCMenuItemFont itemFromString:[NSString stringWithFormat:@"map: %d",j] target:self selector: @selector(GoToMap:)];
            [label setFontSize: 15];
            [label setFontName: @"Marker Felt"];
            [label setTag:j];
            
            if (sort%3 == 0)
                [label setPosition:ccp(screenSize.width/2 + 160, screenSize.height/2)]; // 3
            else if (sort%2 == 0)
                [label setPosition:ccp(screenSize.width/2, screenSize.height/2)]; // 2
            else
                [label setPosition:ccp(screenSize.width/2 - 160, screenSize.height/2)]; // 1
            
            CCMenu *menu = [CCMenu menuWithItems:label, nil];
            [menu setPosition:ccp(0, 0)];
            
            //hinh anh
            BOOL isClick = NO;
            CCSprite *avatar;
            CCMenuItemImage *map;
            
            if (j > [unlockmap intValue])
                avatar = [CCSprite spriteWithFile: @"iphone-pickmap-lock.png"];
            else
            {
                map = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat: @"iphone-pickmap-%d.png", j] selectedImage:[NSString stringWithFormat: @"iphone-pickmap-%d.png", j] target:self selector:@selector(GoToMap:)];
                [map setTag:j];
                isClick = YES;
            }
            
            if (isClick)
            {
                CCMenu *menu = [CCMenu menuWithItems: map, nil];
                [menu setPosition: ccp(postion-5,screenSize.height/2)];
                [layer addChild: menu];
            }
            else
            {
                [avatar setPosition: ccp(postion-5,screenSize.height/2)];
                [layer addChild: avatar];
            }
            
            CCSprite *frame = [CCSprite spriteWithFile: @"iphone-pickmap-frame.png"];
            [frame setPosition: ccp(postion,screenSize.height/2)];
            [layer addChild:frame];
            
            
            ++j;
            if (++sort > map_per_page)
            {
                break;
            }
            postion += 240;
        }
        
        [pagescene addObject: layer];
        [layer release];
    }
    
    // khoi tao scroll layer
    CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:pagescene widthOffset: 0];
    [scroller setMinimumTouchLengthToChangePage: 50.0f];
    
    // cuoi cung them no vao self
    [self addChild:scroller];

}

-(void)GoToMap:(id)sender
{
    //stop background music
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    //khi load map se ton 1 khoang dung luong
    [CGlobalVariables SetMapPlay: [[CBusiMap node] initWithMap:[sender tag]]];

    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMap scene] ]];
}

-(void)dealloc
{
    
    [CGlobalSprite RemoveSprite: background];
    [CGlobalSprite RemoveSprite: sprite1];
    [CGlobalSprite RemoveSprite: sprite2];
    [CGlobalLayer RemoveLayerWithLayer: self];   
    
    [super dealloc];
}

@end
