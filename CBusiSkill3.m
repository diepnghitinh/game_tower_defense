//
//  CBusiSkill2.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiSkill3.h"
#import "CInfoSkill3.h"
#import "CBusiMap.h"

@implementation CBusiSkill3

-(id)init
{
    if (self=[super init])
    {
        info = [[CInfoSkill3 alloc] init];
    }
    return self;
}

-(void)Core:(CGlobalCamera2D*)camera coordinate:(CGPoint)coor
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    if (coor.x > busmap.camera2D.content.contentSize.width/2)
    {
        animation = [CGlobalAnimation Skill:@"skill3-1"];
        spriteEffect = [CCSprite spriteWithSpriteFrameName:@"3149-1.png"];
    }
    else
    {
        animation = [CGlobalAnimation Skill:@"skill3-2"];
        spriteEffect = [CCSprite spriteWithSpriteFrameName:@"3150-1.png"];
    }
    
    [super Core:camera coordinate:coor];
}


@end
