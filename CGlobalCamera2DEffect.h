//
//  CGlobalCamera2DEffect.h
//  defensequest
//
//  Created by dntmaster on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CGlobalCamera2DEffect : CCActionInterval <NSCopying>
{
	float _startZoom;
	float _endZoom;
    float _delta;
    SEL _exec;
    id _target;
}
+(id) actionWithDuration: (ccTime)duration from:(float) s to:(float)e target:(id)target method:(SEL)exec;
-(id) initWithDuration: (ccTime) t from:(float) s to:(float)e target:(id)target method:(SEL)exec;
@end