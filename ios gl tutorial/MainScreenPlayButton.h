//
//  MainScreenPlayButton.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/11/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameGui.h"

@interface MainScreenPlayButton : GameGui
-(CGRect)getBoundingBox;

-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;


@end

