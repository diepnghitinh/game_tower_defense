//
//  CBusiSkill.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BootStrap.h"
#import "CInfoSkill.h"
#import "CBusiSprite.h"

@interface CBusiSkill : NSObject
{
    CInfoSkill *info;
    //sprite effect dung chung
    CCSprite *spriteEffect;
    //animation
    NSMutableArray* animation;
    //do delay cua skill
    float delay;
}

@property (readwrite,retain) CInfoSkill *info;

-(void)Core:(CGlobalCamera2D*)camera coordinate:(CGPoint)coor;
-(float)Distance:(id)enemy;

@end
