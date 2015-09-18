//
//  PauseScreenResumeButton.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameGui.h"

@interface PauseScreenResumeButton : GameGui
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

@end
