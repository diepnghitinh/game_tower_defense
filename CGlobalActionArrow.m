//
//  CGlobalArrowAction.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalActionArrow.h"
#import "CGlobalActionSlow.h"
#import "CBusiStation.h"
#import "CBusiEnemy.h"
#import "CBusiMap.h"

@implementation CGlobalActionArrow

+(id) actionWithSpeed:(float)speed sprite:(CCSprite*)sprite animate:(id)action station:(id)station enemy:(id)enemy
{	
	return [[[self alloc] initWithSpeed:speed sprite:sprite animate:action station:station enemy:enemy] autorelease];
}

-(id) initWithSpeed:(float)speed sprite:(CCSprite*)sprite animate:(id)action station:(id)station enemy:(id)enemy
{
	if( (self=[super init]) )
    {
        station_ = station;
        enemy_ = enemy;
        action_ = action;
        endPosition_ = ((CBusiEnemy*)enemy_).position;
        startPosition_ = [[(CBusiStation*)station_ body] position];
        speed_ = speed;
        arrow = sprite;
	}
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	CCAction *copy = [[[self class] allocWithZone: zone] initWithSpeed: speed_ sprite:arrow animate:action_ station:station_ enemy:enemy_];
	return copy;
}

-(void) startWithTarget:(CCNode *)aTarget
{
	[super startWithTarget:aTarget];
    //tien trinh move
	delta_ = startPosition_;
    //NSLog(@"bay: %f , %f", delta_.x, delta_.y);
    road_ = ccpNormalize( ccpSub( endPosition_, startPosition_) );
    [arrow runAction: action_];
}

-(void) step:(ccTime) dt
{
    float dis = ccpDistance(((CBusiEnemy*)enemy_).position, delta_);
    
    if (dis > 40)
    {
        delta_ = ccpAdd(delta_, ccpMult(road_, speed_));
        //xoay mui ten
        //vector a la vector co tam huong theo truc ox
        CGPoint vA = ccpSub(CGPointMake(delta_.x, delta_.y+1), delta_);
        //vector b la vector co tam va huong theo vertor indetify
        CGPoint vB = ccpSub(((CBusiEnemy*)enemy_).position, delta_);
        
        //tinh acos giua vector a và b
        float angle = acos(ccpDot( ccpNormalize(vA), ccpNormalize(vB)));
        //ban than acos se tinh dc goc giua 2 vector tuy nhien lai chi tra ve phan goc nho nhat
        //neu vb.x > va.X thi la duoi 180 do
        if (vB.x > vA.x)
            angle = CC_RADIANS_TO_DEGREES(angle);
        else
            angle = CC_RADIANS_TO_DEGREES(CC_DEGREES_TO_RADIANS(360)-angle);
        
        [target_ setRotation: angle];
        [target_ setPosition: delta_];
    }
    else
    {
        //da ban trung enemy, stop mui ten lai
        [self stop];
        
        //no ra bang sat'
        id action = [CCSequence actions: [CCRepeat actionWithAction: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [[CGlobalAnimation Effect] objectForKey:@"ice-effect"] delay:0.1f]] times: 1.0f], [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
        [arrow setPosition: endPosition_];
        //thuc hien hieu ung
        [arrow runAction: action];
        //slow enemy lai, thoi gian slow se bang level cua station
        
        if (((CBusiEnemy*)enemy_).statusEffect == 1)
        {
            //NSLog(@"slow1: %d", ((CBusiEnemy*)enemy_).statusEffect);
            //action = [CGlobalActionSlow actionWithDuration:((CBusiStation*)station_).info.level target:enemy_];
            action = [CGlobalActionSlow actionWithDuration:5 target:enemy_];
            [((CBusiEnemy*)enemy_).body runAction: action];
        }
        
        //phan xu ly va cham enemy
        [((CBusiEnemy*)enemy_) Hits: ((CBusiStation*)station_).info.damage];
    }
    
    //cho mui ten duoi theo enemy
    endPosition_ = ((CBusiEnemy*)enemy_).position;
    road_ = ccpSub( endPosition_, delta_);
}

-(void)attackEnd
{
    //remove mui ten di sau khi effect xong
    [arrow removeFromParentAndCleanup: YES];
}

-(BOOL) isDone
{
	return isDone;
}

-(void) stop
{
    isDone = YES;
	[super stop];
}

@end
