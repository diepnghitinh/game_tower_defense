//
//  CBusSkill0.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiSkill1.h"
#import "CInfoSkill1.h"

@implementation CBusiSkill1

-(id)init
{
    if (self=[super init])
    {
        info = [[CInfoSkill1 alloc] init];
    }
    return self;
}

-(void)Core:(CGlobalCamera2D*)camera coordinate:(CGPoint)coor
{
    animation = [CGlobalAnimation Skill:@"skill1"];
    spriteEffect = [CCSprite spriteWithSpriteFrameName:@"682-1.png"];
    
    [super Core:camera coordinate:coor];
}

@end
