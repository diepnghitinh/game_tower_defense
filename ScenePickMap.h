//
//  ScenePickMap.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "CCScrollLayer.h"
#import "CDataDatabase.h"
#import "SceneMap.h"

@interface ScenePickMap : CCLayer {
    
    //danh sach cac doi tuong map
    NSMutableArray *mapList;
    //background
    CCSprite *background, *sprite1, *sprite2;
    CCMenuItemSprite *exit;
}

+(CCScene *) scene;
-(void)DrawContentIphone;
-(void)DrawContentIpad;

@end
