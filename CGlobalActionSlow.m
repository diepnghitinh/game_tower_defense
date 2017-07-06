//
//  CGlobalActionSlow.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalActionSlow.h"
#import "CBusiEnemy.h"
#import "CGlobalActionEnemyMove.h"
#import "CGlobalMapGrid.h"
#import "SimpleAudioEngine.h"

@implementation CGlobalActionSlow

+(id) actionWithDuration: (ccTime)duration target:(id)target
{
	return [[[self alloc] initWithDuration: duration target:(id)target] autorelease];
}

-(id) initWithDuration: (ccTime) t target:(id)target
{
	if( (self=[super initWithDuration:t]) ) {
        enemy_ = target;
	}
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration: duration_ target:enemy_];
	return copy;
}

-(void) startWithTarget:(CCNode *)aTarget
{
	[super startWithTarget:aTarget];
    
    if (((CBusiEnemy*)enemy_).statusEffect == 2)
    {
        isStop = YES;
        return;
    }
    
    //gan speed cua enemy thanh 2 giay slow
    tmpSpeed = ((CBusiEnemy*)enemy_).info.speed;
    //toc do lam cham chung
    ((CBusiEnemy*)enemy_).info.speed = 2;
    //cho enemy bien thanh mau xanh
    [((CBusiEnemy*)enemy_).body setColor:ccc3(0, 191, 255)];
    //set trang thai slow
    ((CBusiEnemy*)enemy_).statusEffect = 2;
    
    //load sound normal female
    [[SimpleAudioEngine sharedEngine] playEffect:@"snow.wav"];
    
    [self SetSlow];
}

-(BOOL)isDone
{
    if ([super isDone])
        return YES;
    return isStop;
}

-(void)SetSlow
{
    //stop tat ca action cua enemy
    [((CBusiEnemy*)enemy_) stopActionByTag: 0];

    id move = [CGlobalActionEnemyMove actionWithDuration: ((CBusiEnemy*)enemy_).info.speed position:[CGlobalMapGrid IndexToCoor: ((CBusiEnemy*)enemy_).nextMove]];
    
    move = [CCSequence actions:move, [CCCallFunc actionWithTarget:((CBusiEnemy*)enemy_) selector:@selector(moveEnd)], nil];
    //di chuyen co tag == 0
    [move setTag: 0];
    
    [enemy_ runAction:move];
}

-(void) update: (ccTime) t
{
    if (isStop == YES && [self isDone] == YES)
        return;
    
    if ([self isDone] == YES)
    {
        //phuc hoi enemy tro lai binh thuong
        //gan speed cua enemy thanh slow
        ((CBusiEnemy*)enemy_).info.speed = tmpSpeed;
        //NSLog(@"speed: %f", tmpSpeed);
        //cho enemy bien thanh mau xanh
        [((CBusiEnemy*)enemy_).body setColor:ccc3(255, 255, 255)];
        //set trang thai slow
        ((CBusiEnemy*)enemy_).statusEffect = 1;        
        //tra lai trang thai di chuyen binh thuong cho enemy
        //[self SetSlow];
        [self SetSlow];
    }
}

@end
