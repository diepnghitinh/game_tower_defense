//
//  CBusiStation1.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiStation1.h"
#import "CBusiMap.h"

@implementation CBusiStation1

-(id)init
{
    if (self=[super init])
    {
        animation = [CGlobalAnimation Station1];
        info = [[CInfoStation1 alloc] init];
        soundAttack = @"male-normal.wav";
    }
    return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super ccTouchEnded:touch withEvent: event];
}

-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index
{

    //khoi tao sprite hieu ung
    body = [CCSprite spriteWithSpriteFrameName:[objectManager.FirstObject objectForKey: @"0"]];
    
    [super Exec:camera coordinate:index];
    
    //action
    CCAction *action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal7"] delay:0.1f]]];

    [self DrawStatus];
    [self runAction:action];
    
    //cap nhat sprite vao map
    [camera.content addChild: body z:zindex];
}

-(void)attackSkill1End
{
    
    if ([self Distance] <= info.attack && enemyIndentify != nil && enemyIndentify.deading == NO)
    {
        [enemyIndentify Hits: [[[info.randomSkill objectAtIndex: 0] objectAtIndex:1] damage]*info.level];
        
        [self BloodEffect];
    }
    else
    {
        [self MissEffect];
    }
    
    if (status > 8)
        status -= 8;
    
    //reset lai cac flip
    [self ResetBody];
    isAction = YES;
    
    if (status < 9)
        [self DrawStatus];
    
    [super ApplyAttack];
}

-(void)Skill1Draw
{
    id action;
    //su dung skill
    switch (status)
    {
        case sattack1:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack2"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack2"]]];
            [self runAction:action];
            break;
        case sattack2:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack2"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack2"]]];
            if (enemyIndentify.position.x > position.x)
                body.flipX = YES;
            [self runAction:action];
            break;
        case sattack3:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack2"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack2"]]];
            body.flipX = YES;
            [self runAction:action];
            break;
        case sattack4:
            if (enemyIndentify.position.y > position.y)
            {
                action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack2"] delay:0.1f]], 
                          [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
                action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack2"]]];
            }
            else
            {
                action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack1"] delay:0.1f]], 
                          [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
                action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack1"]]];
                body.flipX = YES;
            }
            [self runAction:action];
            break;
        case sattack5:
            if (enemyIndentify.position.y > position.y)
            {
                action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack2"] delay:0.1f]], 
                          [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
                action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack2"]]];
                body.flipX = YES;
            }
            else
            {
                action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack1"] delay:0.1f]], 
                          [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
                action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack1"]]];
            }
            [self runAction:action];
            break;
        case sattack6:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack1"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack1"]]];
            body.flipX = YES;
            [self runAction:action];
            break;
        case sattack7:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack1"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"s1-attack1"]]];
            if (enemyIndentify.position.x < position.x)
                body.flipX = YES;
            [self runAction:action];
            break;
        case sattack8:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"s1-attack1"] delay:0.1f]],
                      [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1End)], nil];
            action= [CCRepeat actionWithAction:action times: [self CalDelay:[animation objectForKey:@"s1-attack1"]]];
            [self runAction:action];
            break;
        default:
            break;
    }
}

-(void)DrawStatus
{
    //random tuyet chieu
    if (status > 8)
    {
        CInfoSkill *skill = [self GetRandomSkill];
        
        if (skill != nil)
        {
            //thuc thi skill thu 1
            if (skill.name == @"skill1")
                [self Skill1Draw];
            //load sound normal female
            [[SimpleAudioEngine sharedEngine] playEffect:@"male-normal.wav"];
            return;
        }
    }
    
    [super DrawStatus];
}

//kiem tra enemy roi di chuyen den de danh
-(void)UpdateLogic:(ccTime)dt
{
    [super UpdateLogic:dt];
}
    
@end