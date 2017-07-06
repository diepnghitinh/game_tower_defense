//
//  SceneMain.m
//  defensequest
//
//  Created by dntmaster on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneMain.h"
#import "ScenePickMap.h"
#import "SceneAbout.h"
#import "SceneMainLayout.h"
#import "SceneMainDialog.h"
#import "CGlobalSprite.h"
#import "Emty.h"

@implementation SceneMain

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SceneMain *layer = [SceneMain node];
    
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
        
        //layer
        layout = [[SceneMainLayout alloc] init];
        dialog = [[SceneMainDialog alloc] init];
        
        [self addChild: layout];
        [self addChild: dialog];
        
        //init variable
        angle = 0;
        menuClick = -1; //chua click gi het la -1
        
        self.isTouchEnabled = YES;
        
        if (iPad)
            [self IpadDraw];
        else
            [self IphoneDraw];
        
        //load am thanh nen
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgm-1.mp3" loop:YES];
        
	}
	return self;
}

-(void)IpadDraw
{
    //load background main
    spritemainbg = [CCSprite spriteWithFile: @"ipad-main-bg.png"];
    [CGlobalSprite Sprite: spritemainbg];    
    [layout addChild:spritemainbg z:0];
    
    [self ButtonDrawIpad];

}

-(void)IphoneDraw
{
    //load background main
    spritemainbg = [CCSprite spriteWithFile: @"iphone-main-bg.png"];
    [CGlobalSprite Sprite: spritemainbg];    
    [layout addChild:spritemainbg z:0];
    
    //ve cac button menu
    [self ButtonDrawIphone];
}

-(void)ButtonDrawIpad
{
    
    //Khoi tao cac item 
    
    CCMenuItemImage * menuNewGame = [CCMenuItemImage  itemFromNormalImage:@"ipad-main-ngame.png"
                                                            selectedImage: @"ipad-main-ngame-hover.png"                                    
                                                                   target:self                                     
                                                                 selector:@selector(doNewgame:)];
    
	CCMenuItemImage * menuContinue = [CCMenuItemImage itemFromNormalImage:@"ipad-main-continue.png"
                                                            selectedImage: @"ipad-main-continue-hover.png"
                                                                   target:self
                                                                 selector:@selector(doContinue:)];
    
    
	CCMenuItemImage * menuUsers = [CCMenuItemImage itemFromNormalImage:@"ipad-main-user.png"
                                                         selectedImage: @"ipad-main-user-hover.png"
                                                                target:self
                                                              selector:@selector(doUsersGuide:)]; 
    
    CCMenuItemImage * menuExit = [CCMenuItemImage itemFromNormalImage:@"ipad-main-exit.png"
                                                        selectedImage: @"ipad-main-exit-hover.png"
                                                               target:self
                                                             selector:@selector(doExit:)]; 
    
	// tao và add cac item vao menu chinh
	CCMenu *myMenu = [CCMenu menuWithItems:menuNewGame,menuContinue,menuExit,menuUsers, nil];
    myMenu.position = CGPointZero;
    
    //xet position cho tung item trong menu    
    menuNewGame.position    = ccp(847,352);
    menuContinue.position   = ccp(640,358);
    menuUsers.position      = ccp(715,210);
    menuExit.position       = ccp(880,168);
    [layout addChild:myMenu];

}
-(void)ButtonDrawIphone
{
    //Khoi tao cac item 
    
    CCMenuItemImage * menuNewGame = [CCMenuItemImage  itemFromNormalImage:@"iphone-main-ngame.png"
                                                            selectedImage: @"iphone-main-ngame-hover.png"                                    
                                                                   target:self                                     
                                                                 selector:@selector(doNewgame:)];
    
	CCMenuItemImage * menuContinue = [CCMenuItemImage itemFromNormalImage:@"iphone-main-continue.png"
                                                            selectedImage: @"iphone-main-continue-hover.png"
                                                                   target:self
                                                                 selector:@selector(doContinue:)];
    
    
	CCMenuItemImage * menuUsers = [CCMenuItemImage itemFromNormalImage:@"iphone-main-user.png"
                                                         selectedImage: @"iphone-main-user-hover.png"
                                                                target:self
                                                              selector:@selector(doUsersGuide:)]; 
    
    CCMenuItemImage * menuExit = [CCMenuItemImage itemFromNormalImage:@"iphone-main-exit.png"
                                                        selectedImage: @"iphone-main-exit-hover.png"
                                                               target:self
                                                             selector:@selector(doExit:)]; 
    
	// tao và add cac item vao menu chinh
	CCMenu *myMenu = [CCMenu menuWithItems:menuNewGame,menuContinue,menuExit,menuUsers, nil];
    myMenu.position = CGPointZero;
    
    //xet position cho tung item trong menu    
    menuNewGame.position    = ccp(418,140);
    menuContinue.position   = ccp(325,140);
    menuUsers.position      = ccp(368,77);
    menuExit.position       = ccp(437,62);
    [layout addChild:myMenu];
    
}

// thuc hien cong viec khi nhan button
- (void) doNewgame: (CCMenuItem  *) menuItem 
{
    CDataDatabase *connect = [[[CDataDatabase alloc] init] autorelease];
    int currentMap = [[connect GetKey: @"currentmap"] intValue];    
    
    //neu map la 0 thi vao thang game
    if (currentMap < 1)
    {
        //go to map
        //set lai next map
        [CGlobalVariables SetMapPlay: [[CBusiMap node] initWithMap: currentMap]];
        
        //replace scene hien tai
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMap scene] ]];
        return;
    }
    
    [((SceneMainLayout*)layout) onExit];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"iClick.wav"];
    
    // get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    //show warning
    dialogWarning = [CCSprite spriteWithFile: @"universal-warning.png"];
    [dialogWarning setPosition: ccp(screenSize.width/2, screenSize.height/2)];
    //add button to dialog
    CCMenuItemImage *yes = [CCMenuItemImage itemFromNormalImage:@"universal-yes.png" selectedImage:@"universal-yes.png" block:^(id sender)
            {
                //connect database
                CDataDatabase *connect = [[[CDataDatabase alloc] init] autorelease];
                [connect UpdateKey:@"currentmap" val: [NSNumber numberWithInt: 0]];
                
                //set lai next map
                [CGlobalVariables SetMapPlay: [[CBusiMap node] initWithMap: 0]];
                
                //replace scene hien tai
                [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene: [SceneMap scene] ]];
                
            }];
    CCMenuItemImage *no = [CCMenuItemImage itemFromNormalImage:@"universal-no.png" selectedImage:@"universal-no.png" block:^(id sender)
            {
                [dialog removeAllChildrenWithCleanup: YES];
                [((SceneMainLayout*)layout) onEnter];
            }];
    CCMenuItemImage *closeButton = [CCMenuItemImage itemFromNormalImage: @"universal-close.png" selectedImage:@"universal-close-hover.png" block:^(id sender)
            {
                [dialog removeAllChildrenWithCleanup: YES];
                [((SceneMainLayout*)layout) onEnter];
            }];
    
    CCMenu *menu = [CCMenu menuWithItems:yes, no, nil];
    [menu alignItemsHorizontally];
    [menu alignItemsHorizontallyWithPadding: 20.0f];
    [menu setPosition: ccp(190,75)];
    [dialogWarning addChild: menu];
    
    CCMenu *close = [CCMenu menuWithItems: closeButton, nil];
    [close setPosition: ccp(345,183)];
    [dialogWarning addChild: close];
    
    [dialog addChild: dialogWarning];
}

- (void) doContinue: (CCMenuItem  *) menuItem 
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"iClick.wav"];
	[[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene:[ScenePickMap scene]]];
    //[[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene:[Emty scene]]];
}
- (void) doUsersGuide: (CCMenuItem  *) menuItem 
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"iClick.wav"];
	[[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene:[SceneAbout scene]]];
}
- (void) doExit: (CCMenuItem  *) menuItem 
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"iClick.wav"];
	exit(0);
}

-(void)dealloc
{    
    //remove sprite
    [CGlobalSprite RemoveSprite: spritemainbg];

    //cac nut menu
    [CGlobalSprite RemoveSprite: sprite1];
    [CGlobalSprite RemoveSprite: sprite2];
    [CGlobalSprite RemoveSprite: sprite3];
    [CGlobalSprite RemoveSprite: sprite4];
    [CGlobalSprite RemoveSprite: sprite5];
    
    [super dealloc];
}

@end
