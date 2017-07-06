//
//  SceneMapMenuVertical.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "BootStrap.h"
#import "SceneMapGround.h"

@interface SceneMapMenu : CCLayer {

    //sprite su dung chung
    CCSprite *spriteHouse, *spriteMoney;
    CCSprite *circle;
    //menu button
    CCMenu *menu;

    CCLabelTTF *round;
    CCLabelTTF *money;
    CCLabelTTF *house;
    
    BOOL isPause, isTouch;
    
}

@property (readwrite,retain) CCMenu *menu;

//ve emenu khi da chon duoc vat pham
-(void)CoreMenu;
-(void)CoreMenuIpad;
-(void)CoreMenuIphone;
-(void)DrawContentIpad;
-(void)DrawContentIphone;

-(void)UpdateWave;
-(void)UpdateCost;
-(void)UpdateHealth;

- (void) Pause;
- (void) unPause;

@end
