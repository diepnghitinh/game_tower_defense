//
//  CGlobalAnimation.h
//  defensequest
//
//  Created by dntmaster on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface CGlobalAnimation : NSObject

//EFFECT
+(NSMutableDictionary*)Effect;
+(NSMutableArray*)Effect:(NSString*)str;
+(void)SetEffect:(NSMutableArray*)frames key:(NSString*)str;

//SKILL
+(NSMutableDictionary*)Skill;
+(NSMutableArray*)Skill:(NSString*)str;
+(void)SetSkill:(NSMutableArray*)frames key:(NSString*)str;

//station 1
+(NSMutableDictionary*)Station1;
+(NSMutableArray*)Station1:(NSString*)str;
+(void)SetStation1:(NSMutableArray*)frames key:(NSString*)str;

//station 2
+(NSMutableDictionary*)Station2;
+(NSMutableArray*)Station2:(NSString*)str;
+(void)SetStation2:(NSMutableArray*)frames key:(NSString*)str;

//station 3
+(NSMutableDictionary*)Station3;
+(NSMutableArray*)Station3:(NSString*)str;
+(void)SetStation3:(NSMutableArray*)frames key:(NSString*)str;

//station 4
+(NSMutableDictionary*)Station4;
+(NSMutableArray*)Station4:(NSString*)str;
+(void)SetStation4:(NSMutableArray*)frames key:(NSString*)str;

//station 5
+(NSMutableDictionary*)Station5;
+(NSMutableArray*)Station5:(NSString*)str;
+(void)SetStation5:(NSMutableArray*)frames key:(NSString*)str;

//station 6
+(NSMutableDictionary*)Station6;
+(NSMutableArray*)Station6:(NSString*)str;
+(void)SetStation6:(NSMutableArray*)frames key:(NSString*)str;

//enemy 1
+(NSMutableDictionary*)Enemy1;
+(NSMutableArray*)Enemy1:(NSString*)str;
+(void)SetEnemy1:(NSMutableArray*)frames key:(NSString*)str;
//enemy 2
+(NSMutableDictionary*)Enemy2;
+(NSMutableArray*)Enemy2:(NSString*)str;
+(void)SetEnemy2:(NSMutableArray*)frames key:(NSString*)str;
//enemy 3
+(NSMutableDictionary*)Enemy3;
+(NSMutableArray*)Enemy3:(NSString*)str;
+(void)SetEnemy3:(NSMutableArray*)frames key:(NSString*)str;
//enemy 4
+(NSMutableDictionary*)Enemy4;
+(NSMutableArray*)Enemy4:(NSString*)str;
+(void)SetEnemy4:(NSMutableArray*)frames key:(NSString*)str;
//enemy 5
+(NSMutableDictionary*)Enemy5;
+(NSMutableArray*)Enemy5:(NSString*)str;
+(void)SetEnemy5:(NSMutableArray*)frames key:(NSString*)str;
//enemy 6
+(NSMutableDictionary*)Enemy6;
+(NSMutableArray*)Enemy6:(NSString*)str;
+(void)SetEnemy6:(NSMutableArray*)frames key:(NSString*)str;

@end
