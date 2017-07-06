//
//  SceneMap.h
//  defensequest
//
//  Created by dntmaster on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneMapGround.h"
#import "SceneMapMenu.h"
#import "SceneMapEffect.h"
#import "SceneMapDialog.h"
#import "ScenePickItem.h"
#import "CBusiMap.h"

@interface SceneMap : CCLayer {

    //doi tuong thong tin map
    CBusiMap *map;
}

+(CCScene *) scene;
-(void)clear;

@end
