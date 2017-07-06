//
//  CGlobalActionDelayItem.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CGlobalActionDelayItem : CCActionInterval <NSCopying>
{
    CCSprite *item;
    CCProgressTimer *delayBar;
    BOOL *refVal;
}

+(id) actionWithDuration: (ccTime)duration target:(id)target ref:(BOOL*)refVal_;
-(id) initWithDuration: (ccTime) t target:(id)target ref:(BOOL*)refVal_;

@end
