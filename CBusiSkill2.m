//
//  CBusiSkill1.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiSkill2.h"
#import "CInfoSkill2.h"

@implementation CBusiSkill2

-(id)init
{
    if (self=[super init])
    {
        info = [[CInfoSkill2 alloc] init];
    }
    return self;
}

-(void)Core:(CGlobalCamera2D*)camera coordinate:(CGPoint)coor
{
    animation = [CGlobalAnimation Skill:@"skill2"];
    spriteEffect = [CCSprite spriteWithSpriteFrameName:@"3022-1.png"];
    [super Core:camera coordinate:coor];
}


@end
