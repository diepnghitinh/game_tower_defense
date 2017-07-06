//
//  CGlobalObjectManager.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoObject.h"
#import "CInfoStation1.h"
#import "CInfoStation2.h"
#import "CInfoStation3.h"
#import "CInfoStation4.h"
#import "CInfoStation5.h"
#import "CInfoStation6.h"
#import "CInfoSkill1.h"
#import "CInfoSkill2.h"
#import "CInfoSkill3.h"
#import "CInfoSkill4.h"

@interface CGlobalObjectManager : NSObject
{
    //danh sach cac item unlock
    NSMutableDictionary *objects;
    //danh sach cac first station
    NSMutableDictionary *fobjects;
}

@property (readwrite, retain) NSMutableDictionary *UnlockObject, *FirstObject; 

//lay cinfo cua object
-(CInfoObject*)GetObject:(int)objectIndex;
//xay dung mot object, add bus cua no vao mang quan ly
-(void)CreateObject:(int)objectIndex coor:(CGPoint)point delay:(int*)val;

@end
