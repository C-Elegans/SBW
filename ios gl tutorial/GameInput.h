//
//  GameInput.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/6/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LeftButton.h"
#import "RightButton.h"
#import "Player.h"
#import "UpButton.h"
#import "PauseButton.h"
@interface GameInput : NSObject
-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
-(nonnull id)init:(nonnull Player*)theplayer leftButton:(nonnull LeftButton*)leftButton rightButton:(nonnull RightButton*)rightButton upButton:(nonnull UpButton*)upButton pauseButton:(nonnull PauseButton*)pauseButton;
-(void)update;
-(void)reset;
@end
