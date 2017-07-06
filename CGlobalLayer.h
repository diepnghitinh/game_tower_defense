//
//  CGlobalLayer.h
//  defensequest
//
//  Created by nguyen phuc nguyen on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface PauseLayerProtocol: CCNode 
-(void)pauseLayerDidPause;
-(void)pauseLayerDidUnpause;
@end

@interface CGlobalLayer : CCLayerColor
{
    PauseLayerProtocol *delegate;
    //thuc thi sau khi pause menu play tro lai
    SEL backexecute;
    CCSprite *dialog;
}

@property (nonatomic,assign)PauseLayerProtocol * delegate;

+ (id) layerWithColor:(ccColor4B)color delegate:(PauseLayerProtocol *)_delegate selector:(SEL)func;
+ (id) layerWithColor:(ccColor4B)color delegate:(PauseLayerProtocol *)_delegate;
- (id) initWithColor:(ccColor4B)c delegate:(PauseLayerProtocol *)_delegate selector:(SEL)func;
- (id) initWithColor:(ccColor4B)c delegate:(PauseLayerProtocol *)_delegate;

-(void)pauseDelegate;

//quan ly, gan va lay layer
+(void)SetLayer:(NSString*)layer classes:(id)object;
+(id)GetLayer:(NSString*)layer;
+(void)RemoveLayer:(NSString*)layer;
+(void)RemoveLayerWithLayer:(CCLayer*)layer;

@end
