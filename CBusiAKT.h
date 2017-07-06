//
//  CBusiAKT.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "CBusiAKTQueue.h"
#import "CGlobalMapGrid.h"

@interface CBusiAKT : NSObject
{
    //trang thai open
    //node = array('g'=>v, 'h'=>v, 'i'=>v, 'p'=>v, 'f'=>v)
    //voi
    //g: quang duong di duoc
    //h: uoc luong do dai thong qua thuat toan Xiaolin Wu, la khoang cach giua node hien tai voi dich.
    //i: node hien tai
    //p: node cha, de xac dinh xem xem neu co nhieu trang thai den Ti thi trang thai tu node nao den Ti la nho nhat
    //f: la tong hai ham g va h
    NSMutableArray *open;
    //toa do diem ket thuc
    int end;
    //do thi
    NSMutableArray* graph;
    //kich thuoc do thi
    int grow, gcol;
    //enemy cua path
    id enemy;
    //path duong di
    NSMutableArray *path;
}

@property (readonly) int grow, gcol, end;

-(id)initWithGraph: (NSMutableArray*)_graph enemy:(id)_enemy;
//method la dang tim duong, air = 1, ground = 0
-(NSArray*)Solver:(int) start end: (int)_end method:(int)method;
//Xiaolin Wu: tinh khoang cach 2 diem rang cua
-(int)Distance: (int)index;
//khoi tao node
-(void)SetUpState: (NSMutableDictionary *) open g:(id)g h:(id)h i:(id)i p:(id)p f:(id)f;
//tinh diem lan can
//mang duoc danh dau tu diem "cuoi duoi trai" sang phai va cu the lap lai
-(int)Relative:(int)node index:(int)index;
-(int)RelativeAir:(int)node index:(int)index;
//kiem tra node co nam trong ma tran hay ko
-(BOOL)CheckRelative:(int)row col:(int)col;
-(BOOL)CheckAirRelative:(int)row col:(int)col;

-(void)RemovePointToMap:(NSNumber*)point;

@end
