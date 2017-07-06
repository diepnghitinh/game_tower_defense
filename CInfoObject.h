//
//  CInfoObject.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CInfoObject : NSObject
{
    float radius;
    int damage, delay, cost;
    NSString *name;
}

@property (readwrite) float radius;
@property (readwrite) int damage, delay, cost;
@property (readwrite, retain) NSString *name;

@end
