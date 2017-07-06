//
//  DialogBox.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DialogBox.h"

@implementation DialogBox

-(id)initWithContent:(CCLayer*)_content;
{
    if (self=[super init])
    {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        //[[CGlobalLayer GetLayer:@"mapdialog"] removeChildByTag:1 cleanup:YES];
        content = _content;
        [self setPosition:ccp(screenSize.width/2, screenSize.height/2)];
        [self addChild: content];
        self.visible = NO;
        [[CGlobalLayer GetLayer:@"mapdialog"] addChild: self z:0 tag:1];
    }
    return self;
}

-(void)ShowContent
{
    self.visible = YES;
}

@end
