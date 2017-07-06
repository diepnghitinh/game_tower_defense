//
//  CInfoStation.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CInfoObject.h"

@interface CInfoStation : CInfoObject
{
    //khoang cach tam danh
    int attack;
    //damage vat ly
    int level;
    
    //damage skill
    //voi key la ty le ra don va value la cinfoskill
    NSMutableArray *randomSkill;
}

@property (readwrite) int level, attack;
@property (readwrite, retain) NSMutableArray *randomSkill;

@end
