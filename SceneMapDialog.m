//
//  SceneMapDialog.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneMapDialog.h"

@implementation SceneMapDialog

-(id) init
{
	if( (self=[super init] )) {
	}
	return self;
}

- (void) onEnter
{
    [super onEnter];
}

- (void) onExit
{
    [super onExit];
}

//thuc thi sau khi bat lai layer
-(void)resumeLayer
{
    //cho phep hien thi tro lai menu
    [[(SceneMapMenu*)[CGlobalLayer GetLayer:@"mapmenu"] menu] setVisible: YES];
}

- (void) dealloc
{ 
    NSLog(@"dialog dealloc");
	[super dealloc];
}

@end
