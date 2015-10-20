//
//  Button.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/19/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameGui.h"
#import "TextBox.h"
@interface Button : GameGui
@property float width;
@property float height;
@property TextBox* text;
-(id)initWithPositionX:(float)x y:(float)y width:(float)width height:(float)height text:(NSString*)string view:(nonnull UIView *)view;
-(void)onClick;
@end
