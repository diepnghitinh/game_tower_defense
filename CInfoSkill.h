//
//  CInfoSkill.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CInfoObject.h"

@interface CInfoSkill : CInfoObject
{
    //tuyet ky co thuoc tinh bang, lam cham doi tuong
    int slow;
}

@property (readwrite) int slow;

@end
