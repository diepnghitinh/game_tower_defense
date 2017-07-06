//
//  CGlobalSprite.h
//  defensequest
//
//  Created by dntmaster on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CGlobalSprite : NSObject

+(void) Sprite: (CCSprite*)sprite;
+(void) SetPostion: (CCSprite*)sprite point:(CGPoint)point;
+(void) RemoveSprite:(CCSprite *)sprite;

@end
