//
//  CBusiAKTQueue.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBusiAKTQueue : NSObject
{
    NSMutableArray *data;
}

@property (readonly,retain) NSMutableArray *data;

-(id)Pop;
-(void)Push: (NSMutableDictionary*)node;
//kiem tra hang doi rong
-(BOOL)IsEmpty;
//huy tat ca cac node trong hang doi
-(void)RemoveAll;

@end
