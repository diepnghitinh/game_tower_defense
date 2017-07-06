//
//  CBusiEnemy4.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiEnemy4.h"

@implementation CBusiEnemy4

-(id)init
{
    if (self=[super init])
    {
        animation = [CGlobalAnimation Enemy4];
        info = [[CInfoEnemy4 alloc] init];
        //day la air
        method = 1;
    }
    return self;
}

-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index
{
    
    body = [CCSprite spriteWithSpriteFrameName: @"npc_1017-1.png"];
    [self addChild: body];
    
    [super Exec:camera coordinate:index];
    
    [hpBg setPosition:ccp(0,40)];
    
    NSMutableArray *frames = [CGlobalAnimation Enemy4:@"move7"];
    action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: frames delay:0.1f]]];
    
    [self DrawStatus];
    
    [self schedule:@selector(UpdateLogic:) interval:0.03];
    
}

-(void)UpdateLogic:(ccTime)dt
{
    [super UpdateLogic:dt];
}

@end
