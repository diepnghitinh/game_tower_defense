//
//  CBusiMap.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CGlobalMapGrid.h"
#import "CGlobalCamera2D.h"
#import "CDataMap.h"
#import "CBusiStation.h"

#import "CBusiEnemy1.h"
#import "CBusiEnemy2.h"
#import "CBusiEnemy3.h"
#import "CBusiEnemy4.h"
#import "CBusiEnemy5.h"
#import "CBusiEnemy6.h"

@interface CBusiMap : CCLayer
{
    //noi dung cua map
    CCSprite *content;
    //mang luu tru chuong ngai vat cua ban do
    NSMutableArray *maparray;
    int mapid;
    //mang luu tru cac station cua ban do
    NSMutableDictionary *stations;
    //mang luu tru cac enemy cua ban do
    NSMutableDictionary *enemys;
    //danh sach cac diem ban
    NSMutableDictionary *busys;
    //mang sap xep enemy theo tieu chi gan dich nhat
    NSMutableDictionary *enemysLength;
    NSMutableArray *enemysSorted;
    
    //danh sach cac enemy khong tim duoc duong di
    NSMutableDictionary *enemysPath;
    //diem uoc luong khi keo vat pham vao
    int estimatePoint;
    
    //mang luu tru cac item su dung cho luot choi
    NSMutableArray *items;
    //map info
    CInfoMap *mapinfo;
    //camera pointer
    CGlobalCamera2D *camera2D;
    //thoi giam khoi dong map
    long time;
    //so enemy hien tai da ra trong map va tong so enemy
    int cenemy, tenemy;
    //co it nhat 1 enemy con song thi bien nay thanh YES
    BOOL isEnemyLive;
}

@property (readwrite, retain) CCSprite *content;
@property (readwrite, retain) NSMutableArray *maparray;
@property (readwrite, retain) NSMutableDictionary *stations;
@property (readwrite, retain) NSMutableDictionary *enemys;
@property (readwrite, retain) NSMutableDictionary *busys;
@property (readwrite, retain) NSMutableDictionary *enemysLength;
@property (readwrite, retain) NSMutableDictionary *enemysPath;

@property (readwrite, retain) NSMutableArray *enemysSorted;
@property (readwrite, retain) NSMutableArray *items;

@property (readwrite, retain) CInfoMap *mapinfo;
@property (readwrite, retain) CGlobalCamera2D *camera2D;
@property (readonly) long time;
@property (readwrite) int mapid, estimatePoint;
@property (readwrite) BOOL isEnemyLive;

-(id) init:(int)name;
-(id) initWithMap:(int)name;
-(void) initWithCamera: (CGlobalCamera2D*)camera;
//func them mot station vao map
-(void) addStation:(id)station index:(int)index;
-(void) removeStation:(id)station;
//func them mot enemy vao map
-(void) addEnemy:(id)enemy Id:(NSString*)Id index:(int)index;
-(void) removeEnemy:(id)enemy;
//xay dung hieu ung skill len map
-(void) addSkill:(id)skill coor:(CGPoint)point;
//tra ve 1 object voi tham so truyen vao la loai enemy
-(id) getTypeEnemy: (id)i;
//cap nhat thong tin tai top info
-(void)UpdateWave;
-(void)UpdateCost;
-(void)UpdateHealth;

@end
