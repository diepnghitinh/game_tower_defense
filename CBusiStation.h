//
//  CBusiStation.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "BootStrap.h"
#import "SimpleAudioEngine.h"
#import "CGlobalObjectManager.h"
#import "CGlobalMapGrid.h"
#import "CInfoStation1.h"
#import "CBusiSprite.h"
#import "CBusiEnemy.h"
#import "CBusiAKT.h"

//trang thai cua station
enum statusStation {
    snormal1 = 1, //tren trai
    snormal2 = 2, //tren
    snormal3 = 3, //tren phai
    snormal4 = 4, //trai
    snormal5 = 5, //phai
    snormal6 = 6, //duoi trai
    snormal7 = 7, //duoi
    snormal8 = 8, //duoi phai
    sattack1 = 9,
    sattack2 = 10,
    sattack3 = 11,
    sattack4 = 12,
    sattack5 = 13,
    sattack6 = 14,
    sattack7 = 15,
    sattack8 = 16,
};

@interface CBusiStation : CCSprite<CCTargetedTouchDelegate>
{
    //sprite body cua station
    CCSprite *body;
    //trang thai cua station
    enum statusStation status;
    //toa do goc va toa do hien tai
    int _key,_index;
    CGRect _rect;
    //camera2D tu cac tang tren truyen xuong
    CGlobalCamera2D *camera2D;
    //postion cua station
    CGPoint position;
    //muc tieu xac dinh de den danh
    CBusiEnemy *enemyIndentify;
    //animation
    NSMutableDictionary* animation;
    //diem di chuyen ke den
    int nextMove;
    //cinfo cua station
    CInfoStation *info;
    //quan ly object manager
    CGlobalObjectManager *objectManager;
    //bien trang thai huong quay cua sprite
    int vstatus;
    //trang thai action
    BOOL isAction;
    //zindex cua object
    int zindex;
    NSString *soundAttack;
}

@property (readwrite,retain) CCSprite *body;
@property (readwrite,retain) CInfoStation *info;
@property (readwrite,retain) CGlobalCamera2D *camera2D;
@property (readonly) int zindex;

-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index;
//set position override nham set lai toa do bang body
-(void)setPosition:(CGPoint)_position;
-(void)setBounding;
-(void)runAction:(id) _action;
//khoang cach tu station den enemy
-(float)Distance;
//khoang cach tu toa do goc den enemy
-(float)Distance:(id)enemy;
//tinh toan delay
-(float)CalDelay:(NSArray*)frames;
//reset body
-(void)ResetBody;
-(void)DrawStatus;
//cap nhat trang thai cho station
//dang linh binh thuong
-(void)UpdateLogic:(ccTime)dt;
-(int)checkStatus:(int)index1 index2:(int)index2;
//phuong thuc kiem tra
-(BOOL)containsTouchLocation;
-(BOOL)doubleTouchLocation: (UITouch *)touch;
//ham lay skill cua moi station
-(CInfoSkill*)GetRandomSkill;
//hieu ung fun mau khi chem trung enemy
-(void)BloodEffect;
//hieu ung miss khi danh enemy dung chung cho tat ca cac station
-(void)MissEffect;
//kiem tra , cac thuoc tinh sau khi danh xong enemy
-(void)ApplyAttack;
//cap nhat attack
-(void)UpLevel;

@end
