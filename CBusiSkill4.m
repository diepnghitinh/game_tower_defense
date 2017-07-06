//
//  CBusiSkill3.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiSkill4.h"
#import "CInfoSkill4.h"
#import "CBusiMap.h"

@implementation CBusiSkill4

-(id)init
{
    if (self=[super init])
    {
        info = [[CInfoSkill4 alloc] init];
    }
    return self;
}

-(void)Core:(CGlobalCamera2D*)camera coordinate:(CGPoint)coor
{
    animation = [CGlobalAnimation Skill:@"skill4"];
    delay = 0.1455;
    spriteEffect = [CCSprite spriteWithSpriteFrameName:@"3213-1.png"];
    [super Core:camera coordinate:coor];
}

@end
