//
//  TryAgainButton.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/16/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameGui.h"

@interface TryAgainButton : GameGui
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
@end
