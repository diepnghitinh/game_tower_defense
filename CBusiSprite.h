//
//  CBusiSprite.h
//  defensequest
//
//  Created by dntmaster on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CBusiSprite : NSObject
{
    CCSprite *sprite;
}

@property (readwrite,retain) CCSprite *sprite;

-(id)initWithSprite: (CCSprite*)_sprite;
-(void)addTarget:(id)target z:(int)zindex;
-(void)addTarget:(id)target z:(int)zindex action:(id)action remove:(BOOL)val;
-(void)remove;

@end
