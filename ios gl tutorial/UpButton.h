//
//  UpButton.h
//  Small Blue World
//
//  Created by Michael Nolan on 8/12/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameGui.h"

@interface UpButton : GameGui
-(CGRect)getBoundingBox;
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
@property BOOL buttonDown;
@end
