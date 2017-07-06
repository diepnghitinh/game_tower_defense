//
//  CGlobalActionMapResult.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CGlobalEffectMapResult : NSObject
{
    ccTime duration_;
    CCNode *layer_;
    int nextMap, replay;
    CCSprite *youwin;
    CCSprite *youlose;
}

+(id) actionWithMethod:(int)result;
-(id) initWithMethod:(int)result;
-(void)Lose;

@end
