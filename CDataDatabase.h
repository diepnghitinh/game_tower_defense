//
//  CDataMapInfo.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDataDatabase : NSObject
{
    NSMutableDictionary *data;
    NSString *file;
}

-(id)initWithFile: (NSString*)filename;
-(id)GetKey:(NSString*)key;
-(void)UpdateKey:(NSString*)key val:(id)value;
-(void)DeleteKey:(NSString*)key;
-(void)InsertKey:(NSString*)key val:(id)value;

@end
