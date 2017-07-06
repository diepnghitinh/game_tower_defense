//
//  CGlobalSprite.m
//  defensequest
//
//  Created by dntmaster on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalSprite.h"


@implementation CGlobalSprite

//sprite, toa do tam
+(void) Sprite:(CCSprite *)sprite
{
    //set origin vao toa do tam
    sprite.anchorPoint = ccp(0,0);
}

+(void) SetPostion: (CCSprite*)sprite point:(CGPoint)point
{
    sprite.position = point;
}

+(void) RemoveSprite:(CCSprite *)sprite
{
    [[CCTextureCache sharedTextureCache] removeTexture: sprite.texture];
    [sprite removeFromParentAndCleanup: YES];
}

@end
