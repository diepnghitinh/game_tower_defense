//
//  SceneMapEffect.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneMapEffect.h"

@implementation SceneMapEffect

-(id) init
{
	if( (self=[super init] )) {
	}
	return self;
}

- (void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-2 swallowsTouches:NO];
    [super onEnter];
}

- (void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"==================");
    //NSLog(@"effect began");
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
   //NSLog(@"effect end");
}

- (void) dealloc
{ 
    NSLog(@"effect dealloc");
	[super dealloc];
}

@end
