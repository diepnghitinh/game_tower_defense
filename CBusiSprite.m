//
//  CBusiSprite.m
//  defensequest
//
//  Created by dntmaster on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiSprite.h"

@implementation CBusiSprite

@synthesize sprite;

-(id) initWithSprite:(CCSprite *)_sprite
{
    if (self=[super init])
    {
        sprite = _sprite;
    }
    return self;
}

//them sprite cho mot layer
-(void)addTarget:(id)target z:(int)zindex
{
    [target addChild: sprite z:zindex];
}

//ap dung action cho sprite
-(void)addTarget:(id)target z:(int)zindex action:(id)action remove:(BOOL)val
{
    
    if (val == YES)
    {
        action = [CCSequence actions: [action copy] , [CCCallFunc actionWithTarget:self selector:@selector(remove)], nil];
    }
    
    [sprite runAction:action];
    [self addTarget:target z:zindex];
}

//sau khi thuc hien xong animation thi tu dong xoa
-(void) remove
{
    [sprite removeFromParentAndCleanup:true];
}

@end
