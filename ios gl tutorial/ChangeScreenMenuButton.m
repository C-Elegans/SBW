//
//  ChangeScreenMenuButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/11/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "ChangeScreenMenuButton.h"
#import "GameGuiProtectedMethods.h"
#import "OpenGLViewController.h"
#define WIDTH 1.6
#define HEIGHT 0.35

@implementation ChangeScreenMenuButton

-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y width:WIDTH height:HEIGHT text:@"Main Menu" view:view];
	return self;
}

-(void)onClick{


	[OpenGLViewController getController].gameState = MAIN;
	[OpenGLViewController getController].currentLevel = 0;
	[[OpenGLViewController getController] resetPlayerAndInput];
	
	
}
@end
