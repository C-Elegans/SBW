//
//  LiveScreenButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LiveScreenButton.h"
#import "GameGuiProtectedMethods.h"
#import "OpenGLViewController.h"

#define WIDTH 1.6
#define HEIGHT 0.35
@implementation LiveScreenButton

-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y width:WIDTH height:HEIGHT text:@"Lives" view:view];
	return self;
}

-(void)onClick{
	[OpenGLViewController getController].gameState = AD;
}
@end
