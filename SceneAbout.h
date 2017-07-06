//
//  SceneAbout.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface SceneAbout : CCLayer {
    CCSprite *bg;
    CCMenuItemSprite *exit;
    CCSprite *sprite1;
    CCSprite *sprite2;
}

+(CCScene *) scene;

-(void)IpadDraw;
-(void)IphoneDraw;

@end
