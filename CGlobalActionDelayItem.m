//
//  CGlobalActionDelayItem.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalActionDelayItem.h"

@implementation CGlobalActionDelayItem

+(id) actionWithDuration: (ccTime)duration target:(id)target ref:(BOOL*)refVal_
{
	return [[[self alloc] initWithDuration: duration target:(id)target ref:refVal_] autorelease];
}

-(id) initWithDuration: (ccTime) t target:(id)target ref:(BOOL*)refVal_
{
	if( (self=[super initWithDuration:t]) ) {
        item = target;
        refVal = refVal_;
	}
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration: duration_ target:item ref: refVal];
	return copy;
}

-(void) startWithTarget:(CCNode *)aTarget
{
	[super startWithTarget:aTarget];
    //[[CCTouchDispatcher sharedDispatcher] removeDelegate:target_];
    //[target_ onExit];
   
    //[target_ setTouchDelegate: nil];
    
    //xet vat pham dang delay
    *refVal = YES;
    
    if (iPad)
        delayBar = [CCProgressTimer progressWithFile:@"ipad-icon-delay.png"];
    else
        delayBar = [CCProgressTimer progressWithFile:@"iphone-icon-delay.png"];
    
    delayBar.type = kCCProgressTimerTypeRadialCCW;
    [delayBar setPercentage:100];
    
    [target_ addChild: delayBar z: 1];
}

-(void) update: (ccTime) t
{
    [delayBar setPercentage: (100-100*t)];
    if ([self isDone] == YES)
    {
        //[target_ onEnter];
        [delayBar removeFromParentAndCleanup: YES];
        *refVal = NO;
    }
}

@end
