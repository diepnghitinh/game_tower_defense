//
//  CBusiStation6.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiStation6.h"
#import "CBusiMap.h"
#import "CGlobalActionArrow.h"

@implementation CBusiStation6

-(id)init
{
    if (self=[super init])
    {
        animation = [CGlobalAnimation Station6];
        info = [[CInfoStation6 alloc] init];
        soundAttack = @"bow_atk.mp3";
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
    body = [CCSprite spriteWithSpriteFrameName:[objectManager.FirstObject objectForKey: @"5"]];

    [super Exec:camera coordinate:index];
    
    //action
    CCAction *action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal7"] delay:0.1f]]];
    
    [self DrawStatus];
    [self runAction:action];
    
    //cap nhat sprite vao map
    [camera.content addChild: body z:zindex];
}

//update cho station dang binh thuong
//kiem tra enemy roi di chuyen den de danh
-(void)UpdateLogic:(ccTime)dt
{
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];

    //kiem tra enemy roi tien den danh
    for (id key in busmap.enemysSorted)
    {
        //neu chua xac dinh dc enemy nao va enemy sap xac dinh phai nam trong ban kinh, uu tien enemy gan dich nhat
        if ([self Distance: [busmap.enemys objectForKey: key]] < info.radius && [[busmap.enemys objectForKey:key] deading] == NO && [[[busmap.enemys objectForKey: key] info] isKindOfClass: [CInfoEnemyAir class]])
        {
            enemyIndentify = [busmap.enemys objectForKey:key];
            break;
        }
    }
    
    if (enemyIndentify == nil)
        return;
    
    if (enemyIndentify.dead == YES)
    {
        enemyIndentify = nil;
        return;
    }

    float distance = [self Distance: enemyIndentify];
    
    //huy theo duoi enemy neu vuot ngoai ban kinh
    if ((enemyIndentify != nil && distance > info.radius) || distance == -1)
    {
        enemyIndentify = nil;
    }
    
    if (enemyIndentify == nil && status <= 8 && isAction == YES)
    {
        [self DrawStatus];
        isAction = NO;
    }
    
    //neu tim thay enemy thi danh
    if (enemyIndentify != nil && status <= 8)
    {
        //dieu kien danh la enemy phai nho hon 2 o
        if ([self Distance] <= info.attack)
        {
            //xet lai trang thai chien dau
            vstatus = [self checkStatus: _index index2:enemyIndentify.index];
            
            //NSLog(@"danh");
            
            switch(vstatus)
            {
                case 1:
                    status = sattack1;
                    break;
                case 2:
                    status = sattack2;
                    break;
                case 3:
                    status = sattack3;
                    break;
                case 4:
                    status = sattack4;
                    break;
                case 5:
                    status = sattack5;
                    break;
                case 6:
                    status = sattack6;
                    break;
                case 7:
                    status = sattack7;
                    break;
                default:
                    status = sattack8;
                    break;
            }
            [self DrawStatus];
        }
    }

}

-(void)attackEnd
{
    if ([self Distance] <= info.attack && enemyIndentify != nil && enemyIndentify.deading == NO)
    {
        CCSprite *arrow = [CCSprite spriteWithSpriteFrameName:@"arrow-image1.png"];
        
        id action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [[CGlobalAnimation Effect] objectForKey:@"ice-arrow"] delay:0.2f]]];
        //enemy nay khac nil nen khong sao
        //tao action mui ten ban ra voi toc do quy dinh
        action = [CGlobalActionArrow actionWithSpeed:0.1 sprite:arrow animate:action station:self enemy: enemyIndentify];
        [arrow runAction: action];
        [camera2D.layer addChild: arrow];
    }
    else
        [self MissEffect];
    
    if (status > 8)
        status -= 8;
    
    if (status < 9)
        [self DrawStatus];
    
    [super ApplyAttack];
    
}

-(void)attackSkill1EndEffect
{
    //tru mau enemy
    [enemyIndentify Hits: [[[info.randomSkill objectAtIndex: 0] objectAtIndex:1] damage]*info.level];
    [super ApplyAttack];
}

-(void)attackSkill1End
{
    
    if ([self Distance] <= info.attack && enemyIndentify != nil && enemyIndentify.deading == NO)
    {
        CCSprite *spriteEffect = [CCSprite spriteWithSpriteFrameName:@"3238-1.png"];
        id action;
        action = [CCAnimation animationWithFrames:[[CGlobalAnimation Effect] objectForKey:@"archer-skill2-effect"] delay: 0.1f];
        action = [CCAnimate actionWithAnimation:action];
        action = [CCSequence actions: action, 
                  [CCCallFunc actionWithTarget:self selector:@selector(attackSkill1EndEffect)], [CCCallFunc actionWithTarget:spriteEffect selector:@selector(removeFromParentAndCleanup:)], nil];
        //khoi tao sprite hieu ung
        [spriteEffect setPosition: enemyIndentify.position];
        //thuc hien hieu ung
        [spriteEffect runAction:action];
        [camera2D.layer addChild: spriteEffect];
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
    id action;
    
    //random tuyet chieu
    if (status > 8)
    {
        CInfoSkill *skill = [self GetRandomSkill];
        
        if (skill != nil)
        {
            //thuc thi skill thu 1
            if (skill.name == @"skill1")
            {
                [self Skill1Draw];
                //load sound normal female
                [[SimpleAudioEngine sharedEngine] playEffect:@"skill-3.wav"];
            }
            return;
        }
    }
    
    switch (status)
    {
        case snormal1:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal1"] delay:0.1f]]];
            [self runAction:action];
            break;
        case snormal2:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal2"] delay:0.1f]]];
            [self runAction:action];
            break;
        case snormal3:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal3"] delay:0.1f]]];
            [self runAction:action];
            break;
        case snormal4:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal4"] delay:0.1f]]];
            [self runAction:action];
            break;
        case snormal5:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal5"] delay:0.1f]]];
            [self runAction:action];
            break;
        case snormal6:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal6"] delay:0.1f]]];
            [self runAction:action];
            break;
        case snormal7:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal7"] delay:0.1f]]];
            [self runAction:action];
            break;
        case snormal8:
            action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"normal8"] delay:0.1f]]];
            [self runAction:action];
            break;
        case sattack1:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack1"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times: 1.0f];
            [self runAction:action];
            break;
        case sattack2:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack2"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:1.0f];
            [self runAction:action];
            break;
        case sattack3:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack3"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:1.0f];
            [self runAction:action];
            break;
        case sattack4:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack4"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:1.0f];
            [self runAction:action];
            break;
        case sattack5:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack5"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:1.0f];
            [self runAction:action];
            break;
        case sattack6:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack6"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:1.0f];
            [self runAction:action];
            break;
        case sattack7:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack7"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:1.0f];
            [self runAction:action];
            break;
        case sattack8:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack8"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:1.0f];
            [self runAction:action];
            break;
    }
}

@end
