//
//  SceneMap.m
//  defensequest
//
//  Created by dntmaster on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneMap.h"
#import "SimpleAudioEngine.h"

@implementation SceneMap

+(CCScene *) scene
{    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    NSLog(@"RELOAD: %@", scene);
    
    //khoi tao cac lop layer cho scene map
    
    //layer mat dat
    SceneMapGround *mapground = [SceneMapGround node];
    //them layer vao global de quan ly pause tai ui button o layer2
    [CGlobalLayer SetLayer:@"mapground" classes: mapground];
    
    //layer menu giua
    SceneMapMenu *mapmenu = [SceneMapMenu node];
    [CGlobalLayer SetLayer:@"mapmenu" classes: mapmenu];

    //layer bat buoc chon item khi vua bat dau choi game
    ScenePickItem *pickitem = [ScenePickItem node];
    [CGlobalLayer SetLayer:@"pickitem" classes: pickitem];
    
	// 'layer' is an autorelease object.
	SceneMap *layer = [SceneMap node];
    
    //them vao scene map
    //gom mapground va map menu cho cung 1 layer, layer nay se la noi hien thi effect cho game
    SceneMapEffect *mapeffect = [SceneMapEffect node];
    [mapeffect addChild: mapground];
    [mapeffect addChild: mapmenu];
    [CGlobalLayer SetLayer:@"mapeffect" classes: mapeffect];    
    
    //layer hien thi cac dialog, chua luon effect
    SceneMapDialog *mapdialog = [SceneMapDialog node];
    [mapdialog addChild: mapeffect z:0 tag:0];
    [CGlobalLayer SetLayer:@"mapdialog" classes: mapdialog];
    
    [layer addChild: mapdialog];
    [layer addChild: pickitem];
    
	// add layer as a child to scene
	[scene addChild: layer];
    [CGlobalLayer SetLayer:@"mapmain" classes: layer];
    
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self = [super init]) )
    {
	}
	return self;
}

-(void)clear
{
    //remove all layer
    [CGlobalLayer RemoveLayer: @"mapground"];
    [CGlobalLayer RemoveLayer: @"mapmenu"];
    [CGlobalLayer RemoveLayer: @"pickitem"];
    [CGlobalLayer RemoveLayer: @"mapeffect"];
    [CGlobalLayer RemoveLayer: @"mapdialog"];
    [CGlobalLayer RemoveLayer: @"mapmain"];
}

- (void) dealloc
{
    
    NSLog(@"map dealloc: %@", self);
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [self removeAllChildrenWithCleanup: YES];
    
	[super dealloc];
}

@end
