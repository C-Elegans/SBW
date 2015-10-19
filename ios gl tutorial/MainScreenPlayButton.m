//
//  playButton.m
//  Small Blue World
//
//  Created by Michael Nolan on 8/12/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "MainScreenPlayButton.h"
#import "GameGuiProtectedMethods.h"
#import "OpenGLViewController.h"
#define WIDTH 2.5
#define HEIGHT 0.35
@implementation MainScreenPlayButton
-(id)initWithPositionX:(float)x y:(float)y view:(UIView *)view{
	self = [super initWithPositionX:x y:y width:WIDTH height:HEIGHT text:@"Play!" view:view];
	return self;
}
-(void)onClick{
	[OpenGLViewController getController].gameState = RUNNING;	
}



@end
