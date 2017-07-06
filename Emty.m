//
//  Emty.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Emty.h"


@implementation Emty

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Emty *layer = [Emty node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
	}
	return self;
}

@end
