//
//  ScenePickItem.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CGlobalLayer.h"
#import "CCScrollLayer.h"
#import "SceneLayerBackground.h"
#import "CDataDatabase.h"

@interface ScenePickItem : CCLayer {

    SceneLayerBackground *LayerBackground;
    //danh sach cac item da duoc unlock
    int unlockItem;
    //danh sach toa do items su dung
    CGPoint itemsPoint[7];
    //danh sach toa do items chon
    NSMutableDictionary *itemsChose;
    //danh sach cac item chon
    NSMutableDictionary *itemsChoseList;
    //danh sach cac item chon
    NSMutableDictionary *itemsChoseSprite;
    //danh sach theo thu tu items da chon de vao choi game
    NSMutableDictionary *itemsUseList;
    //stack index
    int itemsIndex;
    //sprite su dung de opacity
    CCSprite *sprite;
    //background
    CCSprite *background;
    CCMenuItemImage *next;
}

-(void)FirstLoad;
-(void)DrawContentIpad;
-(void)DrawContentIphone;
-(void)PauseLayer;
-(void)ResumeLayer;

@end
