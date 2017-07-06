//
//  CBusiEnemy6.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiEnemy6.h"

@implementation CBusiEnemy6

-(id)init
{
    if (self=[super init])
    {
        animation = [CGlobalAnimation Enemy6];
        info = [[CInfoEnemy6 alloc] init];
        //day la group
        method = 0;
    }
    return self;
}

-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index
{
    body = [CCSprite spriteWithSpriteFrameName: @"npc_7589-1.png"];
    [self addChild: body];

    [super Exec:camera coordinate:index];
    
    [hpBg setPosition:ccp(5,45)];
    
    NSMutableArray *frames = [CGlobalAnimation Enemy6:@"move7"];
    action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: frames delay:0.1f]]];
    
    [self DrawStatus];
    
    [self schedule:@selector(UpdateLogic:) interval:0.03];
    
}

-(void)UpdateLogic:(ccTime)dt
{
    [super UpdateLogic:dt];
}

@end
