//
//  CGlobalLayer.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalLayer.h"
#import "SimpleAudioEngine.h"
#import "ScenePickMap.h"

//luu tru cac layer
static NSMutableDictionary *layers = nil;

@implementation CGlobalLayer

@synthesize delegate;

+ (id) layerWithColor:(ccColor4B)color delegate:(id)_delegate selector:(SEL)func
{
	return [[[self alloc] initWithColor:color delegate:_delegate selector:func] autorelease];
}

+ (id) layerWithColor:(ccColor4B)color delegate:(id)_delegate
{
	return [[[self alloc] initWithColor:color delegate:_delegate] autorelease];
}

- (id) initWithColor:(ccColor4B)c delegate:(id)_delegate selector:(SEL)func {
    self = [super initWithColor:c];
    if (self != nil) {
        
        //gan selector
        backexecute = func;
        
        [self setContentSize: [_delegate contentSize]];
        [self setAnchorPoint:ccp(0, 0)];
        
		delegate = _delegate;
		[self pauseDelegate];
        
        CCSprite *sprite1, *sprite2;
        
        if (iPad)
        {
            sprite1 = [CCSprite spriteWithFile: @"ipad-play-pause.png" rect:CGRectMake(48, 0, 48, 48)];
            sprite2 = [CCSprite spriteWithFile: @"ipad-play-pause.png" rect:CGRectMake(48, 0, 48, 48)];
        }
        else
        {
            sprite1 = [CCSprite spriteWithFile: @"iphone-play-pause.png" rect:CGRectMake(32, 0, 32, 32)];
            sprite2 = [CCSprite spriteWithFile: @"iphone-play-pause.png" rect:CGRectMake(32, 0, 32, 32)];
        }
        
        // get screen size
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        //show warning
        dialog = [CCSprite spriteWithFile: @"universal-dialog-exit.png"];
        [dialog setPosition: ccp(screenSize.width/2, screenSize.height/2)];
        //add button to dialog
        CCMenuItemImage *yes = [CCMenuItemImage itemFromNormalImage:@"universal-yes.png" selectedImage:@"universal-yes.png" block:^(id sender)
                                {
                                    [[CGlobalLayer GetLayer: @"mapmain"] clear];
                                    
                                    [[CGlobalLayer GetLayer: @"mapmain"] release];
                                    
                                    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:1.0f scene:[ScenePickMap scene]]];
                                }];
        CCMenuItemImage *no = [CCMenuItemImage itemFromNormalImage:@"universal-no.png" selectedImage:@"universal-no.png" target:self selector:@selector(doResume:)];
        
        CCMenu *menu = [CCMenu menuWithItems:yes, no, nil];
        [menu alignItemsHorizontally];
        [menu alignItemsHorizontallyWithPadding: 20.0f];
        [menu setPosition: ccp(190,75)];
        [dialog addChild: menu];
        
        CCMenuItemImage *closeButton = [CCMenuItemImage itemFromNormalImage: @"universal-close.png" selectedImage:@"universal-close-hover.png" target:self selector:@selector(doResume:)];
        
        CCMenu *close = [CCMenu menuWithItems: closeButton, nil];
        [close setPosition: ccp(345,183)];
        [dialog addChild: close];

        [self addChild: dialog z:1];
        
    }
    return self;
}

- (id) initWithColor:(ccColor4B)c delegate:(id)_delegate
{
    self = [super initWithColor:c];
    if (self != nil) {
        
        [self setContentSize: [_delegate contentSize]];
        [self setAnchorPoint:ccp(0, 0)];
        
		delegate = _delegate;
		[self pauseDelegate];        
    }
    return self;
}

-(void)pauseDelegate
{
	if([delegate respondsToSelector:@selector(pauseLayerDidPause)])
    {
		[delegate pauseLayerDidPause];
    }
	[delegate onExit];
	[delegate.parent addChild:self z:10];
}

-(void)doResume: (id)sender
{
	[delegate onEnter];
	if([delegate respondsToSelector:@selector(pauseLayerDidUnpause)])
    {
		[delegate pauseLayerDidUnpause];
    }
	[self.parent removeChild:self cleanup:YES];
    //thuc thi lai backexecute
    [delegate performSelector:backexecute];
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}

+(void)SetLayer:(NSString*)layer classes:(id)object
{
    //khoi tao lai layer, layers moi se bang layers cu
    if (layers == nil)
        layers = [[NSMutableDictionary alloc] init];
    
    if ([layers objectForKey: layer] == nil)
        [layers setObject: object forKey: layer];
    else
    {
        [CGlobalLayer RemoveLayer: layer];
        [CGlobalLayer SetLayer:layer classes:object];
    }
}

+(void)RemoveLayer:(NSString*)layer
{
    if ([layers objectForKey: layer] != nil)
    {        
        [layers removeObjectForKey: layer];
    }
}

+(void)RemoveLayerWithLayer:(CCLayer*)layer
{
    [layer removeAllChildrenWithCleanup: YES];
    [layer removeFromParentAndCleanup: YES];
}

+(id)GetLayer:(NSString*)layer
{    
    return [layers valueForKey:layer];
}

-(void)dealloc
{
	[super dealloc];
}

@end
