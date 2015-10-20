//
//  ChangeScreenNextButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/11/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "ChangeScreenNextButton.h"
#import "GameGuiProtectedMethods.h"
#import "OpenGLViewController.h"
#define WIDTH 1.6
#define HEIGHT 0.35

@interface ChangeScreenNextButton (){
	CGRect frameRect;
	UIView* parentView;
	
}
@end
@implementation ChangeScreenNextButton
const Vertex nextButtonVertices[] = {
	0,0,0,              0,1,
	0,HEIGHT,0,            0,0,
	WIDTH,HEIGHT,0,          1,0,
	WIDTH,0.0f,0.0f,     1,1,
};
const GLushort nextButtonIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y width:WIDTH height:HEIGHT text:@"Next" view:view];
	return self;
}

-(void)onClick{
	[OpenGLViewController getController].currentLevel++;
	[[OpenGLViewController getController] resetPlayerAndInput];
	[OpenGLViewController getController].gameState = RUNNING;
}
@end