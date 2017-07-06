//
//  CBusiEnemy5.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiEnemy5.h"

@implementation CBusiEnemy5

-(id)init
{
    if (self=[super init])
    {
        animation = [CGlobalAnimation Enemy5];
        info = [[CInfoEnemy5 alloc] init];
        //day la group
        method = 0;
    }
    return self;
}

-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index
{
    body = [CCSprite spriteWithSpriteFrameName: @"npc_7017-1.png"];
    [self addChild: body];
    
    [super Exec:camera coordinate:index];
    
    [hpBg setPosition:ccp(5,45)];
    
    NSMutableArray *frames = [CGlobalAnimation Enemy5:@"move7"];
    action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: frames delay:0.1f]]];
    
    [self DrawStatus];
    
    [self schedule:@selector(UpdateLogic:) interval:0.03];
    
}

-(void)UpdateLogic:(ccTime)dt
{
    [super UpdateLogic:dt];
}

@end
