//
//  CGlobalActionSlow.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

/* hieu ung lam cham enemy
 CCActionInterval co can thiep vao framework
 */
@interface CGlobalActionSlow : CCActionInterval <NSCopying>
{
    id enemy_;
    BOOL isStop;
    float tmpSpeed;
}

+(id) actionWithDuration: (ccTime)duration target:(id)target;
-(id) initWithDuration: (ccTime) t target:(id)target;
-(void)SetSlow;

@end