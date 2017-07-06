//
//  SceneMapGround.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

//layer map - mat dat
#import "cocos2d.h"
#import "BootStrap.h"
#import "CDataDatabase.h"
#import "SceneMapMenu.h"
#import "CBusiMap.h"

@interface SceneMapGround : CCLayer<CCTargetedTouchDelegate> {

    //camera2d dung chung
    CGlobalCamera2D *camera2d;
    //tang busi map duoc chon de choi
    CBusiMap *busmap;
    BOOL isPause, isTouch;
}

-(void)PlayBackground;

- (void) Pause;
- (void) unPause;

@end
