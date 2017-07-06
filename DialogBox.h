//
//  DialogBox.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CGlobalLayer.h"

@interface DialogBox : CCLayer
{
    CCLayer *content;
}

-(id)initWithContent:(CCLayer*)content;
-(void)ShowContent;

@end
