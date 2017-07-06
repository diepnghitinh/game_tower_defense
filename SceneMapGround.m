//
//  SceneMapGround.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneMapGround.h"


@implementation SceneMapGround

-(id) init
{
	if( (self=[super init] )) {

        //xet kich thuoc cho layout
        //[self setContentSize: CGSizeMake(365,320)];
        
        //cap nhat thong tin map bang map da chon
        busmap = [[CGlobalVariables GetMapPlay] autorelease];
        
        //dinh dang kich thuoc camera bang chinh mapinfo
        camera2d = [[CGlobalCamera2D alloc] initWithSpriteAndLayer: busmap.mapinfo : self];

        [busmap initWithCamera: camera2d];

        [self addChild: busmap];
        [self addChild: camera2d.view];
	}
	return self;
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

-(void)PlayBackground
{
    if ([busmap.mapinfo class] == [CInfoMap0 class])
    {
        //load am thanh nen
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"0.mp3" loop:YES];
        return;
    }
    
    if ([busmap.mapinfo class] == [CInfoMap1 class])
    {
        //load am thanh nen
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"1.mp3" loop:YES];
        return;
    }
    
    if ([busmap.mapinfo class] == [CInfoMap2 class])
    {
        //load am thanh nen
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"2.mp3" loop:YES];
        return;
    }
    
    if ([busmap.mapinfo class] == [CInfoMap3 class])
    {
        //load am thanh nen
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"3.mp3" loop:YES];
        return;
    }
    
    if ([busmap.mapinfo class] == [CInfoMap4 class])
    {
        //load am thanh nen
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"4.mp3" loop:YES];
        return;
    }
}

- (void)onEnter
{
    if(!isPause)
    {    
        if (!isTouch)
        {
            [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
            isTouch = YES;
        }
        [super onEnter];
    }
}

- (void)onExit
{
    if(!isPause)
    {
        [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
        [super onExit];
    }
    isPause = NO;
    isTouch = NO;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"group began");
    [camera2d EventHandleTouchBegan:touch withEvent:event];
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    [camera2d EventHandleTouchMoved:touch withEvent:event];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"group end");
    [camera2d EventHandleTouchEnded:touch withEvent:event];
}

- (void) dealloc
{ 
    NSLog(@"ground dealloc");
	[super dealloc];
}

@end
