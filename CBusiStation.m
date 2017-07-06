//
//  CBusiStation.m
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CBusiStation.h"
#import "CBusiMap.h"
#import "DialogBox.h"
#import "DialogStationInfo.h"
#import "GlobalVariables.h"

@implementation CBusiStation

@synthesize body, info, camera2D, zindex;

-(id)init
{
    if (self=[super init])
    {
        //mac dinh trang thai station la normal 
        status = snormal7;
        //khoi tao chua xac dinh duoc enemy
        enemyIndentify = nil;
        objectManager = [[CGlobalObjectManager alloc] init];
    }
    return self;
}

-(CInfoSkill*)GetRandomSkill
{
    long rd = random()%100;
    
    if ([info.randomSkill count] < 1)
        return nil;
    
    for (int i = 0; i < [info.randomSkill count]; ++i)
    {
        id probability = [[info.randomSkill objectAtIndex: i] objectAtIndex:0];

        if ([[probability objectAtIndex: 0] intValue] <= rd && rd <= [[probability objectAtIndex: 1] intValue])
        {
            return [[info.randomSkill objectAtIndex: i] objectAtIndex:1];
        }
    }
    
    return nil;
}

-(void)Exec:(CGlobalCamera2D*)camera coordinate:(int)index
{
    //set camera2D
    camera2D = camera;
    [self setPosition: [CGlobalMapGrid IndexToCoor: index]];
    //set index hien tai cua station
    _index = index;
    //xet index tro lai cua station
    _key = index;
    //xet zindex
    zindex = [CGlobalMapGrid InverseCoorY:[CGlobalMapGrid IndexToCoor:index]].y;
}

-(void)UpLevel
{
    //tinh damage goc
    info.damage += info.damage/info.level;
    info.level++;
}

-(void)setPosition:(CGPoint)_position;
{
    position = _position;
    body.position = _position;
    _rect = CGRectMake(position.x-40, position.y-40, 80, 80);
    [body setPosition: _position];
}

-(void)setBounding
{
    position = body.position;
    _rect = CGRectMake(position.x-40, position.y-40, 80, 80);
}

-(void)runAction:(id) _action
{
    [self setBounding];
    [body runAction:_action];
}

-(float)Distance
{
    CGPoint pe;
    if (enemyIndentify != nil)
    {
        pe = enemyIndentify.position;
        return ccpDistance(pe, position);
    }
    return -1;
}

-(float)Distance:(id)enemy
{
    CGPoint pe, ps;
    
    if (enemy != nil && ((CBusiEnemy*)enemy).dead == NO)
    {
        pe = ((CBusiEnemy*)enemy).position;
        ps = [CGlobalMapGrid IndexToCoor:_key];
        return ccpDistance(pe, ps);
    }
    return -1;
}

-(void)ResetBody
{
    body.flipX = NO;
    body.flipY = NO;
}

-(BOOL)containsTouchLocation
{
    return CGRectContainsPoint(_rect, ccp(camera2D.indentifypos.x, camera2D.indentifypos.y));
}

-(BOOL)doubleTouchLocation: (UITouch *)touch
{
    if ([self containsTouchLocation] == YES && touch.tapCount > 1)
        return YES;
    return NO;
}

//tinh toan delay
-(float)CalDelay:(NSArray*)frames
{
    float delay = (0.1*[frames count]);
    return delay < 1 ? 1.0f: delay;
}

-(int)checkStatus:(int)index1 index2:(int)index2
{
    
    CGPoint pindex1 = [CGlobalMapGrid IndexToCoor: index1];
    CGPoint pindex2 = [CGlobalMapGrid IndexToCoor: index2];
    
    //vector a la vector co tam huong theo truc ox
    CGPoint vA = ccpSub(CGPointMake(pindex1.x, pindex1.y+1), pindex1);
    //vector b la vector co tam va huong theo vertor indetify
    CGPoint vB = ccpSub(pindex2, pindex1);
    
    //tinh acos giua vector a và b
    float angle = acos(ccpDot( ccpNormalize(vA), ccpNormalize(vB)));

    //ban than acos se tinh dc goc giua 2 vector tuy nhien lai chi tra ve phan goc nho nhat
    //neu vb.x > va.X thi la duoi 180 do
    if (vB.x > vA.x)
        angle = CC_RADIANS_TO_DEGREES(angle);
    else
        angle = CC_RADIANS_TO_DEGREES(CC_DEGREES_TO_RADIANS(360)-angle);
    
    //huong xoay cua tam
    int dic = ceil((angle+22.5) / 45);
    
    switch (dic)
    {
        case 2:
            return 3;
            break;
        case 3:
            return 5;
        case 4:
            return 8;
            break;
        case 5:
            return 7;
            break;
        case 6:
            return 6;
            break;
        case 7:
            return 4;
            break;
        case 8:
            return 1;
            break;
        default:
            return 2;
            break;
    }
    return 0;
}

-(void)DrawStatus
{
    id action;

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
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack2"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack2"]]];
            [self runAction:action];
            break;
        case sattack2:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack2"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack2"]]];
            if (enemyIndentify.position.x > position.x)
                body.flipX = YES;
            [self runAction:action];
            break;
        case sattack3:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack2"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack2"]]];
            body.flipX = YES;
            [self runAction:action];
            break;
        case sattack4:
            if (enemyIndentify.position.y > position.y)
            {
                action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack2"] delay:0.1f]], 
                          [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
                action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack2"]]];
            }
            else
            {
                action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack1"] delay:0.1f]], 
                          [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
                action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack1"]]];
                body.flipX = YES;
            }
            [self runAction:action];
            break;
        case sattack5:
            if (enemyIndentify.position.y > position.y)
            {
                action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack2"] delay:0.1f]], 
                          [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
                action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack2"]]];
                body.flipX = YES;
            }
            else
            {
                action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack1"] delay:0.1f]], 
                          [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
                action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack1"]]];
            }
            [self runAction:action];
            break;
        case sattack6:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack1"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack1"]]];
            body.flipX = YES;
            [self runAction:action];
            break;
        case sattack7:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack1"] delay:0.1f]], 
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times:[self CalDelay:[animation objectForKey:@"attack1"]]];
            if (enemyIndentify.position.x < position.x)
                body.flipX = YES;
            [self runAction:action];
            break;
        case sattack8:
            action = [CCSequence actions: [CCAnimate actionWithAnimation:[CCAnimation animationWithFrames: [animation objectForKey:@"attack1"] delay:0.1f]],
                      [CCCallFunc actionWithTarget:self selector:@selector(attackEnd)], nil];
            action= [CCRepeat actionWithAction:action times: [self CalDelay:[animation objectForKey:@"attack1"]]];
            [self runAction:action];
            break;
        default:
            break;
    }
}

//update cho station dang binh thuong
//kiem tra enemy roi di chuyen den de danh
-(void)UpdateLogic:(ccTime)dt
{
    
    CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
    
    //kiem tra enemy roi tien den danh
    for (id key in busmap.enemysSorted)
    {
        //neu chua xac dinh dc enemy nao va enemy sap xac dinh phai nam trong ban kinh
        if ([self Distance: [busmap.enemys objectForKey: key] ] < info.radius && [[busmap.enemys objectForKey:key] deading] == NO && [[[busmap.enemys objectForKey: key] info] isKindOfClass: [CInfoEnemyGround class]])
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
            
            //load sound normal female
            [[SimpleAudioEngine sharedEngine] playEffect:soundAttack];
            
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

-(void)ApplyAttack
{
   //neu enemy dang trong trang thai chet thi tu bo
   if (enemyIndentify.deading == YES)
       enemyIndentify = nil;
}

-(void)attackEnd
{

    if ([self Distance] <= info.attack && enemyIndentify != nil && enemyIndentify.deading == NO)
    {
        [enemyIndentify Hits: info.damage];
        
        //hieu ung blood
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
    
    [self ApplyAttack];

}

//hieu ung phun mau khi chem trung enemy
-(void)BloodEffect
{
    CCSprite *spriteEffect = [CCSprite spriteWithSpriteFrameName:@"blood-image1.png"];
    id action;
    action = [CCAnimation animationWithFrames:[[CGlobalAnimation Effect] objectForKey:@"blood-effect"] delay: 0.1f];
    action = [CCAnimate actionWithAnimation:action];
    action = [CCSequence actions: action, [CCCallFunc actionWithTarget:spriteEffect selector:@selector(removeFromParentAndCleanup:)], nil];
    //khoi tao sprite hieu ung
    [spriteEffect setPosition: enemyIndentify.position];
    //thuc hien hieu ung
    [spriteEffect runAction:action];
    [camera2D.layer addChild: spriteEffect];
}

//hieu ung miss khi danh enemy dung chung cho tat ca cac station
-(void)MissEffect
{
    //miss effect
    CCLabelTTF *miss = [CCLabelTTF labelWithString:@"Miss" fontName:@"Arial" fontSize:20];
    [miss setColor: ccc3(255, 255, 255)];
    //miss set
    [miss setPosition: position];
    [camera2D.layer addChild: miss];
    
    id moveAction = [CCMoveTo actionWithDuration:0.5 position:ccp(position.x, position.y + 50)];
    id actions = [CCSequence actions: moveAction, [CCCallFunc actionWithTarget:miss selector:@selector(removeFromParentAndCleanup:)],nil];
    [miss runAction:actions];
    enemyIndentify = nil;
}

- (void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:NO];
    [super onEnter];
}

- (void)onExit
{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    if ([self doubleTouchLocation: touch])
    {
        CGPoint pclick = [touch locationInView: [touch view] ];
        pclick = [[CCDirector sharedDirector] convertToGL: pclick];
        
        CBusiMap *busmap = [[CGlobalVariables GetMapPlay] autorelease];
        CGPoint p = [busmap.camera2D.view convertTouchToNodeSpace:touch];
        
        if (CGRectContainsPoint(CGRectMake(position.x-tileSize/2, position.y-tileSize/2, tileSize, tileSize),  p))
        {
            DialogStationInfo *layer = [[DialogStationInfo alloc] initWithItem: _key point: pclick];
        
            DialogBox *dialog = [[DialogBox alloc] initWithContent: layer];
            [dialog ShowContent];
        }
    }
}

@end
