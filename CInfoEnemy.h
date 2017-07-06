//
//  CInfoEnemy.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface CInfoEnemy : NSObject
{
    int level, health, cost;
    float speed;
    NSString *Id;
}

@property (readwrite) int level, health, cost;
@property (readwrite) float speed;
@property (retain,readwrite) NSString *Id;

@end
