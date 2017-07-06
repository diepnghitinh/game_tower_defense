//
//  ShapeCircle.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ShapeCircle : CCSprite
{
    ccColor4B color;
    float radius;
}

-(id) initWithColor:(ccColor4B) _color radius:(float)_radius;
-(void) RefreshColor:(ccColor4B) _color;

@end
