//
//  CBusiEnemy.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BootStrap.h"
#import "CGlobalMapGrid.h"
#import "CBusiSprite.h"
#import "CBusiAKT.h"
#import "CInfoEnemy1.h"
#import "CInfoEnemy2.h"
#import "CInfoEnemy3.h"
#import "CInfoEnemy4.h"
#import "CInfoEnemy5.h"
#import "CInfoEnemy6.h"

enum statusEnemy {
    emove1 = 1,
    emove2 = 2,
    emove3 = 3,
    emove4 = 4,
    emove5 = 5,
    emove6 = 6,
    emove7 = 7,
    emove8 = 8,
};

enum statusEnemyEffect {
    enormal = 1, //binh thuong
    eslow = 2, //dinh bang
};

@interface CBusiEnemy : CCSprite
{
    //toa do chinh va toa do hien tai
    //trang thai cua enemy
    enum statusEnemy status;
    enum statusEnemyEffect statusEffect;
    
    //animation
    NSMutableDictionary* animation;
    
    int _index;
    CInfoEnemy *info;
    //so mau hien tai
    int health;
    //so tien neu giet dc
    int cost;
    
    CGRect _rect;
    //camera2D tu cac tang tren truyen xuong
    CGlobalCamera2D *camera2D;
    //action
    CCAction *action;
    int nextMove;
    //dung cho animation di chuyen
    BOOL moving;
    //trang thai chet cho enemy, tranh xung dot zombie, khi nao het station danh vao moi remove
    //deading la trang thai' nga xuong truoc khi chet
    BOOL Dead, Deading;
    
    id busmap;
    CBusiAKT *finding;
    NSArray* path;
    NSArray* EstimatePath;
    
    //ong mau enemy
    CCProgressTimer *hpBar;
    
    //thoi gian phan huy
    ccTime timeTrash;
    ccTime elapsed;
    
    //dang object
    int method;
    
    CCSprite *hpBg, *body;
    
    //cho phep danh dau busy
    BOOL isNotAllowBusy;
}

@property (readwrite) BOOL dead, deading;
@property (readwrite) enum statusEnemyEffect statusEffect;
@property (readwrite) int index, health, cost, nextMove;
@property (readwrite, retain) CInfoEnemy *info;
@property (readwrite, retain) CCSprite *body;
@property (readwrite, retain) NSArray *path;

-(id)initWithInfo:(CInfoEnemy*)enemy;
-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index;
-(void)UpdateLogic:(ccTime)dt;
-(void)DrawStatus;
//trung damage
-(void)Hits:(int)damage;
-(void)RefreshHealth;
//set enemy chet chet
-(BOOL)Kill;
//co che phan huy
-(void)MoveTrash:(ccTime)t;
//phuong thuc sap xep mang enemy theo chieu dai
-(void)SortEnemysLength:(NSArray*)path;
//lay parent cua sprite
-(CCNode*)getParent;

@end
