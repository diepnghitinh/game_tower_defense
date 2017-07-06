//
//  CGlobalAnimation.m
//  defensequest
//
//  Created by dntmaster on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CGlobalAnimation.h"

static NSMutableDictionary* station1 = nil;
static NSMutableDictionary* station2 = nil;
static NSMutableDictionary* station3 = nil;
static NSMutableDictionary* station4 = nil;
static NSMutableDictionary* station5 = nil;
static NSMutableDictionary* station6 = nil;

static NSMutableDictionary* enemy1 = nil;
static NSMutableDictionary* enemy2 = nil;
static NSMutableDictionary* enemy3 = nil;
static NSMutableDictionary* enemy4 = nil;
static NSMutableDictionary* enemy5 = nil;
static NSMutableDictionary* enemy6 = nil;

static NSMutableDictionary* skill = nil;
static NSMutableDictionary* effect = nil;

@implementation CGlobalAnimation

//EFFECT
+(NSMutableDictionary*)Effect
{
    return effect;
}

+(NSMutableArray*)Effect:(NSString*)str
{
    return [effect objectForKey:str];
}

+(void)SetEffect:(NSMutableArray*)frames key:(NSString*)str
{
    if ([effect count] < 1)
        effect = [[NSMutableDictionary alloc] init];
    [effect setObject:[frames retain] forKey:str];
}

//SKILL
+(NSMutableDictionary*)Skill
{
    return skill;
}

+(NSMutableArray*)Skill:(NSString*)str
{
    return [skill objectForKey:str];
}

+(void)SetSkill:(NSMutableArray*)frames key:(NSString*)str
{
    if ([skill count] < 1)
        skill = [[NSMutableDictionary alloc] init];
    [skill setObject:[frames retain] forKey:str];
}

//STATION 1
+(NSMutableDictionary*)Station1
{
    return station1;
}

+(NSMutableArray*)Station1:(NSString*)str
{
    return [station1 objectForKey:str];
}

+(void)SetStation1:(NSMutableArray*)frames key:(NSString*)str
{
    if ([station1 count] < 1)
        station1 = [[NSMutableDictionary alloc] init];
    [station1 setObject:[frames retain] forKey:str];
}

//STATION 2
+(NSMutableDictionary*)Station2
{
    return station2;
}

+(NSMutableArray*)Station2:(NSString*)str
{
    return [station2 objectForKey:str];
}

+(void)SetStation2:(NSMutableArray*)frames key:(NSString*)str
{
    if ([station2 count] < 1)
        station2 = [[NSMutableDictionary alloc] init];
    [station2 setObject:[frames retain] forKey:str];
}

//STATION 3
+(NSMutableDictionary*)Station3
{
    return station3;
}

+(NSMutableArray*)Station3:(NSString*)str
{
    return [station3 objectForKey:str];
}

+(void)SetStation3:(NSMutableArray*)frames key:(NSString*)str
{
    if ([station3 count] < 1)
        station3 = [[NSMutableDictionary alloc] init];
    [station3 setObject:[frames retain] forKey:str];
}

//STATION 4
+(NSMutableDictionary*)Station4
{
    return station4;
}

+(NSMutableArray*)Station4:(NSString*)str
{
    return [station4 objectForKey:str];
}

+(void)SetStation4:(NSMutableArray*)frames key:(NSString*)str
{
    if ([station4 count] < 1)
        station4 = [[NSMutableDictionary alloc] init];
    [station4 setObject:[frames retain] forKey:str];
}

//STATION 5
+(NSMutableDictionary*)Station5
{
    return station5;
}

+(NSMutableArray*)Station5:(NSString*)str
{
    return [station5 objectForKey:str];
}

+(void)SetStation5:(NSMutableArray*)frames key:(NSString*)str
{
    if ([station5 count] < 1)
        station5 = [[NSMutableDictionary alloc] init];
    [station5 setObject:[frames retain] forKey:str];
}

//STATION 6
+(NSMutableDictionary*)Station6
{
    return station6;
}

+(NSMutableArray*)Station6:(NSString*)str
{
    return [station6 objectForKey:str];
}

+(void)SetStation6:(NSMutableArray*)frames key:(NSString*)str
{
    if ([station6 count] < 1)
        station6 = [[NSMutableDictionary alloc] init];
    [station6 setObject:[frames retain] forKey:str];
}

//ENEMY 1
+(NSMutableDictionary*)Enemy1
{
    return enemy1;
}
+(NSMutableArray*)Enemy1:(NSString*)str{
    return [enemy1 objectForKey:str];
}
+(void)SetEnemy1:(NSMutableArray*)frames key:(NSString*)str{
    if ([enemy1 count] < 1)
        enemy1 = [[NSMutableDictionary alloc] init];
    [enemy1 setObject:[frames retain] forKey:str];
}
//ENEMY 2
+(NSMutableDictionary*)Enemy2
{
    return enemy2;
}
+(NSMutableArray*)Enemy2:(NSString*)str{
    return [enemy2 objectForKey:str];
}
+(void)SetEnemy2:(NSMutableArray*)frames key:(NSString*)str{
    if ([enemy2 count] < 1)
        enemy2 = [[NSMutableDictionary alloc] init];
    [enemy2 setObject:[frames retain] forKey:str];
}
//ENEMY 3
+(NSMutableDictionary*)Enemy3
{
    return enemy3;
}
+(NSMutableArray*)Enemy3:(NSString*)str{
    return [enemy3 objectForKey:str];
}
+(void)SetEnemy3:(NSMutableArray*)frames key:(NSString*)str{
    if ([enemy3 count] < 1)
        enemy3 = [[NSMutableDictionary alloc] init];
    [enemy3 setObject:[frames retain] forKey:str];
}
//ENEMY 4
+(NSMutableDictionary*)Enemy4
{
    return enemy4;
}
+(NSMutableArray*)Enemy4:(NSString*)str{
    return [enemy4 objectForKey:str];
}
+(void)SetEnemy4:(NSMutableArray*)frames key:(NSString*)str{
    if ([enemy4 count] < 1)
        enemy4 = [[NSMutableDictionary alloc] init];
    [enemy4 setObject:[frames retain] forKey:str];
}
//ENEMY 5
+(NSMutableDictionary*)Enemy5
{
    return enemy5;
}
+(NSMutableArray*)Enemy5:(NSString*)str{
    return [enemy5 objectForKey:str];
}
+(void)SetEnemy5:(NSMutableArray*)frames key:(NSString*)str{
    if ([enemy5 count] < 1)
        enemy5 = [[NSMutableDictionary alloc] init];
    [enemy5 setObject:[frames retain] forKey:str];
}
//ENEMY 6
+(NSMutableDictionary*)Enemy6
{
    return enemy6;
}
+(NSMutableArray*)Enemy6:(NSString*)str{
    return [enemy6 objectForKey:str];
}
+(void)SetEnemy6:(NSMutableArray*)frames key:(NSString*)str{
    if ([enemy6 count] < 1)
        enemy6 = [[NSMutableDictionary alloc] init];
    [enemy6 setObject:[frames retain] forKey:str];
}

@end
