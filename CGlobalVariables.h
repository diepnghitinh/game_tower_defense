//
//  CGlobalVariables.h
//  defensequest
//
//  Created by dntmaster on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGlobalVariables : NSObject
{
}

+(NSString *)debugStr;
+(NSString *)setdebugStr:(NSString *)value;

+(id)GetMapPlay;
+(void)SetMapPlay:(id)_mapPlay;

@end
