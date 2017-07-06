//
//  CBusiMap0.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiMap0.h"

@implementation CBusiMap0

-(id) init
{
	if( (self=[super init] )) {
        
        //load a sprite map
        bg = [[CCSprite spriteWithFile:@"0.png"] retain];
        
        //maparray 
        
	}
	return self;
}

-(void)setContent:(CCSprite *)_content
{
    [super setContent:_content];
    
    
}

@end
