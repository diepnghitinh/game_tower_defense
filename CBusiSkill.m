//
//  CBusiSkill.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiSkill.h"
#import "CBusiMap.h"
#import "CBusiEnemy.h"
#import "CGlobalActionSlow.h"

@implementation CBusiSkill

@synthesize info;

-(id)init
{
    if (self=[super init])
    {
        animation = [NSMutableArray array];
        delay = 0.1;
    }
    return self;
}

-(void)Core:(CGlobalCamera2D*)camera coordinate:(CGPoint)coor
{
    //tao action
    id action;
    action = [CCAnimation animationWithFrames: animation delay:delay];
    action = [CCAnimate actionWithAnimation:action];
    action = [CCSequence actions: action, 
              [CCCallFunc actionWithTarget:self selector:@selector(EffectEnd)], nil];
    //khoi tao sprite hieu ung
    [spriteEffect setPosition: coor];
    //thuc hien hieu ung
    [spriteEffect runAction:action];
    [camera.layer addChild: spriteEffect];
}

-(float)Distance:(id)enemy
{
    CGPoint pe;
    if (enemy != nil)
    {
        pe = ((CBusiEnemy*)enemy).position;
        return ccpDistance(pe, spriteEffect.position);
    }
    return -1;
}

-(void)EffectEnd
{
    
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    //[enemyIndentify Hits: info.damage];
    //kiem tra enemy roi tien den danh
    for (id key in busmap.enemys)
    {
        //neu chua xac dinh dc enemy nao va enemy sap xac dinh phai nam trong ban kinh, uu tien enemy gan dich nhat
        if ([self Distance: [busmap.enemys objectForKey: key]] < info.radius && [[busmap.enemys objectForKey:key] deading] == NO)
        {
            CBusiEnemy *enemy = [busmap.enemys objectForKey: key];
            //skill co slow
            if (enemy.statusEffect == 1 && info.slow > 0)
            {
                id action = [CGlobalActionSlow actionWithDuration: info.slow target:enemy];
                [enemy runAction: action];
                NSLog(@"slow");
            }
            
            //tac dong skill vao
            [enemy Hits: info.damage];
        }
    }
    
    [[CCTextureCache sharedTextureCache] removeTexture: spriteEffect.texture];
    [spriteEffect removeFromParentAndCleanup: YES];
    [self release];
}

-(void)dealloc
{
    [[CCActionManager sharedManager] removeAllActionsFromTarget: self];
    [super dealloc];
}

@end
