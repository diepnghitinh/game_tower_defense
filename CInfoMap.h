//
//  CInfoMap.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CInfoMap : NSObject
{
    CCSprite *bg;
    NSMutableArray *maparray;
    int cost;
    int health;
    int currentWave;
    NSString *name;
    NSMutableDictionary *enemys;
    int itemUnlock;
    int row, col, end, start;
}

@property (readwrite,retain) CCSprite *bg;
@property (readwrite,retain) NSMutableArray *maparray;
@property (readwrite) int cost, health, wave, row, col, end, start, itemUnlock;
@property (readwrite,retain) NSString *name;
@property (readwrite,retain) NSMutableDictionary *enemys;

//ve map 2.5d
-(void)Core3d:(CCNode*)content;

@end