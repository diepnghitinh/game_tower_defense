//
//  CGlobalArrowAction.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CGlobalActionArrow : CCAction <NSCopying>
{
    CGPoint startPosition_;
    CGPoint endPosition_;
    CGPoint road_;
    CGPoint delta_;
    id station_;
    id enemy_;
    id action_;
    //toc do bay
    float speed_;
    BOOL isDone;
    //sprite mui ten
    CCSprite *arrow;
}

+(id) actionWithSpeed:(float)speed sprite:(CCSprite*)sprite animate:(id)action station:(id)station enemy:(id)enemy;
-(id) initWithSpeed:(float)speed sprite:(CCSprite*)sprite animate:(id)action station:(id)station enemy:(id)enemy;

@end