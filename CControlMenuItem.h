//
//  CControlMenuItem.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CGlobalLayer.h"
#import "CGlobalObjectManager.h"
#import "ShapeCircle.h"
#import "CInfoObject.h"
#import "CBusiMap.h"

@interface CControlMenuItem : CCSprite<CCTargetedTouchDelegate>
{
    CCSprite *item;
    int itemIndex;
    //cac dieu kien ve event
    //isDrag la xem xem dang su dung item la click hay la keo tha
    BOOL isClick, isDrag, isUse, isError;
    //co ve hinh tron pham vi danh hay chua?
    BOOL isDraw;
    ShapeCircle *circle;
    CCSprite *rect, *itemObject;
    //class quan ly cac object
    CGlobalObjectManager *objectManager;
    CBusiMap *busmap;
    //rect nhan event click
    CGRect _bounding;
    //dang o trang thai delay
    int delay;
    BOOL isDelay;
    //diem keo tha
    CGPoint point;
    //diem luu truoc do' cua index keo tha
    int tmpPath;
}

//property item
@property (readwrite, retain) CCSprite *item;
@property (readwrite) BOOL isClick, isUse;
@property (readwrite) CGRect bounding;

-(id)initWithItem:(int)i;
-(void)SetBounding;
-(void)SetChecked:(BOOL)val;
-(BOOL)CheckBuilt:(CGPoint)point_;
-(BOOL)IsHaveObject:(int)index;

@end
