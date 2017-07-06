//
//  SceneMain.h
//  defensequest
//
//  Created by dntmaster on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "BootStrap.h"

@interface SceneMain : CCLayer {
    //sprite su dung chung
    CCSprite *spriteEffect, *spritemainbg, *sprite1, *sprite2, *sprite3, *sprite4, *sprite5, *dialogWarning;
    //goc xoay button menu
    int angle;
    //cac rect button
    //CGRect spriteRect[5];
    int menuClick;
    //cac layer
    CCLayer *layout;
    CCLayer *dialog;
}

+(CCScene *) scene;
-(void)ButtonDrawIphone;
-(void)ButtonDrawIpad;
-(void)IpadDraw;
-(void)IphoneDraw;

@end
