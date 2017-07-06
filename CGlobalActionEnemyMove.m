//
//  CGlobalActionEnemyMove.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalActionEnemyMove.h"
#import "CGlobalMapGrid.h"
#import "CBusiEnemy.h"

@implementation CGlobalActionEnemyMove

//orverride ccmoveto
-(void) update: (ccTime) t
{
    [super update: t];
    
    //cap nhat zindex
    [[((CBusiEnemy*)target_) getParent] reorderChild:target_ z: [CGlobalMapGrid InverseCoorY: [target_ position]].y ]; 
}

@end
