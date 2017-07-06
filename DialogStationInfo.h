//
//  DialogStationInfo.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "CGlobalObjectManager.h"
#import "CGlobalLayer.h"

@interface DialogStationInfo : CCLayer
{
    //id cua object station, la o dang dung cua no
    int id_;
    CGPoint point_;
    CCSprite *bg;
}

-(id)initWithItem:(int) _id point:(CGPoint)_point;
-(void)Core;
-(void)Cancel:(id)sender;

@end
