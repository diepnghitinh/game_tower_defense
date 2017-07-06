//
//  CDataMap.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CInfoMap0.h"
#import "CInfoMap1.h"
#import "CInfoMap2.h"
#import "CInfoMap3.h"
#import "CInfoMap4.h"
#import "CDataDatabase.h"

@interface CDataMap : NSObject
{
    CInfoMap *mapinfo;
}

@property (readwrite,retain) CInfoMap *mapinfo;

-(id)initWithMap:(int)name;

@end
