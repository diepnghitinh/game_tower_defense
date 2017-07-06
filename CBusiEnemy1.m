//
//  CBusiEnemy1.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiEnemy1.h"

@implementation CBusiEnemy1

-(id)init
{
    if (self=[super init])
    {
        animation = [CGlobalAnimation Enemy1];
        info = [[CInfoEnemy1 alloc] init];
        //day la group
        method = 0;
    }
    return self;
}

-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index
{

    body = [CCSprite spriteWithSpriteFrameName: @"npc_8137-1.png"];
    [self addChild: body];
    
    [super Exec:camera coordinate:index];    
    
    [hpBg setPosition:ccp(10,35)];
    
    NSMutableArray *frames = [CGlobalAnimation Enemy1:@"move7"];
    action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: frames delay:0.1f]]];

    [self DrawStatus];
    
    [self schedule:@selector(UpdateLogic:) interval:0.03];

}

-(void)UpdateLogic:(ccTime)dt
{
    [super UpdateLogic:dt];
    
}

@end
